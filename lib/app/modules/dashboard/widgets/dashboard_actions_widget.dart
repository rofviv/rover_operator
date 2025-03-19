import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

import '../bloc/dashboard_bloc.dart';
import '../utils/sizes_utils.dart';
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
          padding: const EdgeInsets.all(16.0),
          child: Actions(
            actions: <Type, Action<Intent>>{
              LeftArrowIntent: LeftArrowAction(dashboardBloc: dashboardBloc),
              RightArrowIntent: RightArrowAction(dashboardBloc: dashboardBloc),
              ParkingIntent: ParkingAction(dashboardBloc: dashboardBloc),
              DoorIntent: DoorAction(dashboardBloc: dashboardBloc),
              LightIntent: LightAction(dashboardBloc: dashboardBloc),
              ClaxonIntent: ClaxonAction(dashboardBloc: dashboardBloc),
              RetroIntent: RetroAction(dashboardBloc: dashboardBloc),
            },
            child: GlobalShortcuts(
              shortcuts: {
                const SingleActivator(LogicalKeyboardKey.arrowLeft, alt: true):
                    LeftArrowIntent(),
                const SingleActivator(LogicalKeyboardKey.arrowRight, alt: true):
                    RightArrowIntent(),
                const SingleActivator(LogicalKeyboardKey.keyP, alt: true):
                    ParkingIntent(),
                const SingleActivator(LogicalKeyboardKey.keyD, alt: true):
                    DoorIntent(),
                const SingleActivator(LogicalKeyboardKey.keyL, alt: true):
                    LightIntent(),
                const SingleActivator(LogicalKeyboardKey.keyC, alt: true):
                    ClaxonIntent(),
                const SingleActivator(LogicalKeyboardKey.keyR, alt: true):
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
                              message: state.errorMessage,
                              child: GestureDetector(
                                onTap: () => dashboardBloc.getAllDataRover(),
                                child: Icon(
                                  Icons.circle,
                                  color: state.errorMessage.isNotEmpty
                                      ? Colors.red
                                      : Colors.green,
                                  size: 14,
                                ),
                              ),
                            ),
                      const SizedBox(width: 2),
                      Text(
                        " ${state.ipRemote}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        " | ${DateTime.now().difference(state.lastSync ?? DateTime.now()).inSeconds}s",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Tooltip(
                        message: 'Left (ALT + LEFT)',
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
                                  state.leftArrow
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
                            child: state.leftArrow
                                ? Center(
                                    child: Image.asset(
                                      'assets/icons/left_arrow.png',
                                      width: 50,
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
                                    width: 50,
                                    color: Colors.grey.shade700,
                                  ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Tooltip(
                              message: 'Parking (ALT + P)',
                              child: GestureDetector(
                                onTap: () =>
                                    dashboardBloc.add(DashboardParkingEvent()),
                                child: Image.asset(
                                  'assets/icons/parking_brake.png',
                                  width: iconSize,
                                  color: state.parking
                                      ? Colors.amberAccent
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Tooltip(
                              message: 'Door (ALT + D)',
                              child: GestureDetector(
                                onTap: () =>
                                    dashboardBloc.add(DashboardDoorEvent()),
                                child: Container(
                                  color: Colors.transparent,
                                  child: Image.asset(
                                    'assets/icons/car_door.png',
                                    width: iconSize,
                                    color: state.door
                                        ? Colors.amberAccent
                                        : Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Tooltip(
                              message: 'Light (ALT + L)',
                              child: GestureDetector(
                                onTap: () =>
                                    dashboardBloc.add(DashboardLightEvent()),
                                child: Image.asset(
                                  'assets/icons/light.png',
                                  width: iconSize,
                                  color: state.light
                                      ? Colors.amberAccent
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Tooltip(
                              message: 'Claxon (ALT + C)',
                              child: GestureDetector(
                                onTap: () =>
                                    dashboardBloc.add(DashboardClaxonEvent()),
                                child: Image.asset(
                                  'assets/icons/volume.png',
                                  width: iconSize,
                                  color: state.claxon
                                      ? Colors.amberAccent
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Tooltip(
                              message: 'Retro (ALT + R)',
                              child: GestureDetector(
                                onTap: () =>
                                    dashboardBloc.add(DashboardRetroEvent()),
                                child: Image.asset(
                                  'assets/icons/R.png',
                                  width: iconSize,
                                  color: state.retro
                                      ? Colors.amberAccent
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Tooltip(
                        message: 'Right (ALT + RIGHT)',
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
                                  state.rightArrow
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
                            child: state.rightArrow
                                ? Center(
                                    child: Image.asset(
                                      'assets/icons/right_arrow.png',
                                      width: 50,
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
                                    width: 50,
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
