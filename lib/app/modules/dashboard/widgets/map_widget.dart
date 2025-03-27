import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> with TickerProviderStateMixin {
  double zoom = 16;
  LatLng center = LatLng(
    -17.798262949722087,
    -63.177556347059166,
  );
  late final _animatedMapController = AnimatedMapController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    cancelPreviousAnimations: true,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: MediaQuery.of(context).size.width,
      child: FlutterMap(
        mapController: _animatedMapController.mapController,
        options: MapOptions(
          initialCenter: center,
          initialZoom: zoom,
          initialRotation: -80,
          interactionOptions: const InteractionOptions(
            flags: ~InteractiveFlag.doubleTapZoom,
            enableMultiFingerGestureRace: true,
            debugMultiFingerGestureWinner: true,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
            markers: [
              buildPin(
                context,
                center,
                90,
              ),
            ],
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
                    _animatedMapController.animatedZoomIn();
                  },
                  child: Icon(Icons.add, color: Colors.white),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "zoomOut",
                  backgroundColor: Colors.grey.shade800,
                  mini: true,
                  onPressed: () {
                    _animatedMapController.animatedZoomOut();
                  },
                  child: Icon(Icons.remove, color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              heroTag: "resetZoom",
              backgroundColor: Colors.grey.shade800,
              mini: true,
              onPressed: () {
                _animatedMapController.animateTo(dest: center, zoom: zoom);
              },
              child: Icon(Icons.gps_fixed, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Marker buildPin(
          BuildContext context, LatLng point, double bearingInRadians) =>
      Marker(
        point: point,
        width: 60,
        height: 60,
        rotate: false,
        alignment: Alignment.center,
        child: Transform.rotate(
          angle: bearingInRadians / 360 * 2 * pi,
          child: Image.asset(
            "assets/icons/patioRobot.png",
            width: 60,
            height: 60,
          ),
        ),
      );
}
