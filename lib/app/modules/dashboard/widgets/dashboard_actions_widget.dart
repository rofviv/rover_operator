import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

import '../bloc/dashboard_bloc.dart';
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
                                  width: state.sizeIcon,
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
                                    width: state.sizeIcon,
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
                                  width: state.sizeIcon,
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
                                  width: state.sizeIcon,
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
                                  width: state.sizeIcon,
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
