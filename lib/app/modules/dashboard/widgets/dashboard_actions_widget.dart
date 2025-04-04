import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

import '../blocs/dashboard/dashboard_bloc.dart';
import '../utils/relays_data.dart';
import 'shortcuts_intent.dart';

class DashboardActionsWidget extends StatelessWidget {
  const DashboardActionsWidget({
    super.key,
    required this.dashboardBloc,
  });

  final DashboardBloc dashboardBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      bloc: dashboardBloc,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Actions(
            actions: <Type, Action<Intent>>{
              LeftArrowIntent: LeftArrowAction(dashboardBloc: dashboardBloc),
              RightArrowIntent: RightArrowAction(dashboardBloc: dashboardBloc),
              ParkingIntent: ParkingAction(dashboardBloc: dashboardBloc),
              DoorIntent: DoorAction(dashboardBloc: dashboardBloc),
              DoorBackIntent: DoorBackAction(dashboardBloc: dashboardBloc),
              LightIntent: LightAction(dashboardBloc: dashboardBloc),
              ClaxonIntent: ClaxonAction(dashboardBloc: dashboardBloc),
              RetroIntent: RetroAction(dashboardBloc: dashboardBloc),
            },
            child: GlobalShortcuts(
              shortcuts: {
                const SingleActivator(LogicalKeyboardKey.arrowLeft,
                    control: true): LeftArrowIntent(),
                const SingleActivator(LogicalKeyboardKey.arrowRight,
                    control: true): RightArrowIntent(),
                const SingleActivator(LogicalKeyboardKey.keyP, control: true):
                    ParkingIntent(),
                const SingleActivator(LogicalKeyboardKey.keyD, control: true):
                    DoorIntent(),
                const SingleActivator(LogicalKeyboardKey.keyT, control: true):
                    DoorBackIntent(),
                const SingleActivator(LogicalKeyboardKey.keyL, control: true):
                    LightIntent(),
                const SingleActivator(LogicalKeyboardKey.keyB, control: true):
                    ClaxonIntent(),
                const SingleActivator(LogicalKeyboardKey.keyR, control: true):
                    RetroIntent(),
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (state.isLoading)
                          ? const CupertinoActivityIndicator(
                              color: Colors.white,
                            )
                          : Tooltip(
                              message: state.errorMessageHost,
                              child: GestureDetector(
                                onTap: () => dashboardBloc.syncDataRover(),
                                child: Icon(
                                  Icons.circle,
                                  color: state.errorMessageHost.isNotEmpty
                                      ? Colors.red
                                      : Colors.green,
                                  size: 14,
                                ),
                              ),
                            ),
                      const SizedBox(width: 2),
                      Text(
                        " Host: ${state.ipRemote}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (state.isLoadingRelay)
                          ? const CupertinoActivityIndicator(
                              color: Colors.white,
                            )
                          : Tooltip(
                              message: state.errorMessageRelay,
                              child: GestureDetector(
                                onTap: () => dashboardBloc.syncDataRover(),
                                child: Icon(
                                  Icons.circle,
                                  color: state.errorMessageRelay.isNotEmpty
                                      ? Colors.red
                                      : Colors.green,
                                  size: 14,
                                ),
                              ),
                            ),
                      const SizedBox(width: 2),
                      Text(
                        " Relay: ${state.roverStatus.ipRelay ?? "-"}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Tooltip(
                        message:
                            "${state.relaysMap[Relays.leftArrow]!.name} (${state.relaysMap[Relays.leftArrow]!.shortcut})",
                        // message: "${state.leftArrow.name} (${state.leftArrow.shortcut})",
                        child: GestureDetector(
                          onTap: () =>
                              dashboardBloc.add(DashboardLeftArrowEvent()),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              gradient: RadialGradient(
                                colors: [
                                  state.relaysMap[Relays.leftArrow]!.status
                                      ? Colors.amberAccent
                                          .withValues(alpha: 0.1)
                                      : Colors.black,
                                  Colors.grey.shade200,
                                ],
                                center: Alignment.center,
                                radius: 3.0,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0, 0),
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: state.relaysMap[Relays.leftArrow]!.status
                                ? Center(
                                    child: Image.asset(
                                      'assets/icons/left_arrow.png',
                                      width: state.sizeIcon + 20,
                                      color: Colors.grey.shade700,
                                    ),
                                  )
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(),
                                    )
                                    .tint(
                                      color: Colors.amber,
                                      duration:
                                          const Duration(milliseconds: 750),
                                    )
                                : Image.asset(
                                    'assets/icons/left_arrow.png',
                                    width: state.sizeIcon + 20,
                                    color: Colors.grey.shade700,
                                  ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Tooltip(
                              message: 'Parking (CTRL + P)',
                              child: GestureDetector(
                                onTap: () =>
                                    dashboardBloc.add(DashboardParkingEvent()),
                                child: Image.asset(
                                  'assets/icons/parking_brake.png',
                                  width: state.sizeIcon,
                                  color: state.parking
                                      ? Colors.amberAccent
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Tooltip(
                              message:
                                  "${state.relaysMap[Relays.door]!.name} (${state.relaysMap[Relays.door]!.shortcut})",
                              child: GestureDetector(
                                onTap: () =>
                                    dashboardBloc.add(DashboardDoorEvent()),
                                child: Container(
                                  color: Colors.transparent,
                                  child: Image.asset(
                                    'assets/icons/car_door.png',
                                    width: state.sizeIcon,
                                    color: state.relaysMap[Relays.door]!.status
                                        ? Colors.amberAccent
                                        : Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Tooltip(
                              message:
                                  "${state.relaysMap[Relays.doorBack]!.name} (${state.relaysMap[Relays.doorBack]!.shortcut})",
                              child: GestureDetector(
                                onTap: () =>
                                    dashboardBloc.add(DashboardDoorBackEvent()),
                                child: Container(
                                  color: Colors.transparent,
                                  child: Image.asset(
                                    'assets/icons/car_door_back.png',
                                    width: state.sizeIcon,
                                    color: state.relaysMap[Relays.doorBack]!
                                        .status
                                        ? Colors.amberAccent
                                        : Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Tooltip(
                              message:
                                  "${state.relaysMap[Relays.light]!.name} (${state.relaysMap[Relays.light]!.shortcut})",
                              child: GestureDetector(
                                onTap: () =>
                                    dashboardBloc.add(DashboardLightEvent()),
                                child: Image.asset(
                                  'assets/icons/light.png',
                                  width: state.sizeIcon,
                                  color: state.relaysMap[Relays.light]!.status
                                      ? Colors.amberAccent
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Tooltip(
                              message:
                                  "${state.relaysMap[Relays.claxon]!.name} (${state.relaysMap[Relays.claxon]!.shortcut})",
                              child: GestureDetector(
                                onTap: () =>
                                    dashboardBloc.add(DashboardClaxonEvent()),
                                child: Image.asset(
                                  'assets/icons/volume.png',
                                  width: state.sizeIcon,
                                  color: state.relaysMap[Relays.claxon]!.status
                                      ? Colors.amberAccent
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Tooltip(
                              message:
                                  "${state.relaysMap[Relays.retro]!.name} (${state.relaysMap[Relays.retro]!.shortcut})",
                              child: GestureDetector(
                                onTap: () =>
                                    dashboardBloc.add(DashboardRetroEvent()),
                                child: Image.asset(
                                  'assets/icons/R.png',
                                  width: state.sizeIcon,
                                  color: state.relaysMap[Relays.retro]!.status
                                      ? Colors.amberAccent
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              height: 30,
                              child: VerticalDivider(
                                color: Colors.grey.shade700,
                                thickness: 2,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Tooltip(
                              message:
                                  "Sonar front (DISTANCE: ${state.roverStatus.sonarFrontDistance} cm.)",
                              child: GestureDetector(
                                onTap: () {
                                  dashboardBloc.setSonarFrontSensor();
                                },
                                child: Image.asset(
                                  'assets/icons/sonar_sensor.png',
                                  width: state.sizeIcon - 7,
                                  color:
                                      state.roverStatus.sonarFrontStatus == "1"
                                          ? Colors.white
                                          : Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Tooltip(
                              message:
                                  "Sonar back (DISTANCE: ${state.roverStatus.sonarBackDistance} cm.)",
                              child: GestureDetector(
                                onTap: () {
                                  dashboardBloc.setSonarBackSensor();
                                },
                                child: Image.asset(
                                  'assets/icons/sonar_sensor_back.png',
                                  width: state.sizeIcon - 7,
                                  color:
                                      state.roverStatus.sonarBackStatus == "1"
                                          ? Colors.white
                                          : Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Tooltip(
                              message:
                                  "Latency (Max: ${state.roverStatus.latencyTime} ms.)",
                              child: GestureDetector(
                                onTap: () {
                                  dashboardBloc.setLatency();
                                },
                                child: Image.asset(
                                  'assets/icons/latency.png',
                                  width: state.sizeIcon,
                                  color: state.roverStatus.latencyStatus == "1"
                                      ? Colors.white
                                      : Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Tooltip(
                              message:
                                  "Lidar (DISTANCE: ${state.roverStatus.lidarDistance} cm. ANGLE: ${state.roverStatus.lidarAngle}°)",
                              child: GestureDetector(
                                onTap: () {
                                  dashboardBloc.setLidar();
                                },
                                child: Image.asset(
                                  'assets/icons/lidar.png',
                                  width: state.sizeIcon - 7,
                                  color: state.roverStatus.lidarStatus == "1"
                                      ? Colors.white
                                      : Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Tooltip(
                        message: state.relaysMap[Relays.rightArrow]!.shortcut,
                        child: GestureDetector(
                          onTap: () =>
                              dashboardBloc.add(DashboardRightArrowEvent()),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              gradient: RadialGradient(
                                colors: [
                                  state.relaysMap[Relays.rightArrow]!.status
                                      ? Colors.amberAccent
                                          .withValues(alpha: 0.1)
                                      : Colors.black,
                                  Colors.grey.shade200,
                                ],
                                center: Alignment.center,
                                radius: 3.0,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0, 0),
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: state.relaysMap[Relays.rightArrow]!.status
                                ? Center(
                                    child: Image.asset(
                                      'assets/icons/right_arrow.png',
                                      width: state.sizeIcon + 20,
                                      color: Colors.grey.shade700,
                                    ),
                                  )
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(),
                                    )
                                    .tint(
                                      color: Colors.amber,
                                      duration:
                                          const Duration(milliseconds: 750),
                                    )
                                : Image.asset(
                                    'assets/icons/right_arrow.png',
                                    width: state.sizeIcon + 20,
                                    color: Colors.grey.shade700,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
