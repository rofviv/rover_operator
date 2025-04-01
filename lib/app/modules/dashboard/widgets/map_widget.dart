import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../blocs/dashboard/dashboard_bloc.dart';
import '../blocs/location/location_bloc.dart';
import '../blocs/session/session_bloc.dart';

class MapWidget extends StatefulWidget {
  const MapWidget(
      {super.key,
      required this.locationBloc,
      required this.dashboardBloc,
      required this.sessionBloc});

  final LocationBloc locationBloc;
  final DashboardBloc dashboardBloc;
  final SessionBloc sessionBloc;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.locationBloc.initializeMapController(this);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: widget.locationBloc.animatedMapController.mapController,
      options: MapOptions(
        initialCenter: widget.locationBloc.state.center,
        initialZoom: widget.locationBloc.state.zoom,
        interactionOptions: const InteractionOptions(
          flags: ~InteractiveFlag.doubleTapZoom,
          enableMultiFingerGestureRace: true,
          debugMultiFingerGestureWinner: true,
        ),
        onPointerDown: (event, point) {
          widget.locationBloc.add(const LocationDraggingEvent(true));
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        BlocBuilder<DashboardBloc, DashboardState>(
          bloc: widget.dashboardBloc,
          builder: (context, stateDashboard) {
            return BlocBuilder<LocationBloc, LocationState>(
              bloc: widget.locationBloc,
              builder: (context, state) {
                if (!stateDashboard.socketConnected) {
                  return const SizedBox();
                }
                return MarkerLayer(
                  markers: [
                    buildMarkerMaster(
                      context,
                      state.center,
                      state.bearing,
                    ),
                  ],
                );
              },
            );
          },
        ),
        BlocBuilder<SessionBloc, SessionState>(
          bloc: widget.sessionBloc,
          builder: (context, state) {
            return MarkerLayer(
              markers: [
                ...state.orders.map(
                  (order) => Marker(
                    point: LatLng(order.fromLatitude, order.fromLongitude),
                    child: Tooltip(
                      message:
                          "#${order.id.toString()} | ${order.merchantName}",
                      child: Container(
                        decoration: BoxDecoration(
                          color: order.color,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.store,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        BlocBuilder<SessionBloc, SessionState>(
          bloc: widget.sessionBloc,
          builder: (context, state) {
            return MarkerLayer(
              markers: [
                ...state.orders.map(
                  (order) => Marker(
                    point: LatLng(order.toLatitude, order.toLongitude),
                    child: Tooltip(
                      message:
                          "#${order.id.toString()} | ${order.nameUser} | ${order.phoneUser}",
                      child: Container(
                        decoration: BoxDecoration(
                          color: order.color,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Column(
            children: [
              FloatingActionButton(
                heroTag: "zoomIn",
                backgroundColor: Colors.grey.shade800,
                mini: true,
                onPressed: () {
                  widget.locationBloc.add(const LocationDraggingEvent(false));
                  widget.locationBloc.animatedMapController.animatedZoomIn();
                },
                child: const Icon(Icons.add, color: Colors.white),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                heroTag: "zoomOut",
                backgroundColor: Colors.grey.shade800,
                mini: true,
                onPressed: () {
                  widget.locationBloc.add(const LocationDraggingEvent(false));
                  widget.locationBloc.animatedMapController.animatedZoomOut();
                },
                child: const Icon(Icons.remove, color: Colors.white),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Column(
            children: [
              BlocBuilder<LocationBloc, LocationState>(
                bloc: widget.locationBloc,
                builder: (context, state) {
                  return Column(
                    children: [
                      if (state.isDragging)
                        const Icon(
                          Icons.drag_indicator,
                          color: Colors.black,
                        ),
                      const SizedBox(height: 10),
                      FloatingActionButton(
                        heroTag: "compass",
                        backgroundColor: Colors.grey.shade800,
                        mini: true,
                        onPressed: () {
                          widget.locationBloc.add(LocationRotateMapEvent());
                        },
                        child: state.rotateMap
                            ? const Icon(Icons.north, color: Colors.grey)
                            : const Icon(Icons.north, color: Colors.white),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                heroTag: "resetZoom",
                backgroundColor: Colors.grey.shade800,
                mini: true,
                onPressed: () {
                  widget.locationBloc.goToCenter();
                },
                child: const Icon(Icons.gps_fixed, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Marker buildMarkerMaster(
          BuildContext context, LatLng point, double bearingInRadians) =>
      Marker(
        point: point,
        width: 60,
        height: 60,
        rotate: false,
        alignment: Alignment.center,
        child: Transform.rotate(
          angle: bearingInRadians / 360 * 2 * pi,
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.cyan.shade600.withValues(alpha: 0.6),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.cyan.shade800.withValues(alpha: 1),
                      shape: BoxShape.circle,
                    ),
                  )
                      .animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                      .scale(
                        duration: const Duration(milliseconds: 1000),
                        begin: const Offset(0.5, 0.5),
                      )
                      .fadeOut(
                        duration: const Duration(milliseconds: 1000),
                      ),
                ),
                Image.asset(
                  "assets/icons/patioRobot.png",
                ),
                Positioned(
                  top: -20,
                  left: 0,
                  right: 0,
                  child: Icon(
                    Icons.arrow_drop_up,
                    color: Colors.cyan.shade600,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
