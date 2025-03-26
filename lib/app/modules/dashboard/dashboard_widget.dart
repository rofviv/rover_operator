import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/dashboard_bloc.dart';
import 'screens/settings_screen.dart';
import 'widgets/dashboard_actions_widget.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key, required this.dashboardBloc});

  final DashboardBloc dashboardBloc;

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: Colors.black,
      width: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  DashboardActionsWidget(dashboardBloc: dashboardBloc),
                  const SizedBox(height: 20),
                  BlocBuilder<DashboardBloc, DashboardState>(
                    bloc: dashboardBloc,
                    builder: (context, state) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                            "assets/icons/patioRobot.png",
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                            color: state.socketConnected
                                ? null
                                : Colors.grey.shade800,
                          ),
                          if (state.distanceSonar1 > 0)
                            Positioned(
                              left: 0,
                              child: Container(
                                width: 50,
                                height: 5,
                                color: Colors.red,
                              ),
                            ),
                          if (state.distanceSonar2 > 0)
                            Positioned(
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  width: 50,
                                  height: 5,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          if (state.distanceSonar3 > 0)
                            Positioned(
                              right: 0,
                              child: Container(
                                width: 50,
                                height: 5,
                                color: Colors.red,
                              ),
                            ),
                          if (state.distanceSonar4 > 0)
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Center(
                                child: Container(
                                  width: 50,
                                  height: 5,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          Positioned(
                            top: 0,
                            left: -20,
                            bottom: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.cubeStatus.armadoStr ?? '',
                                  style: TextStyle(
                                    color: state.cubeStatus.armadoStr == "ARMED"
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  state.cubeStatus.mode ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  BlocBuilder<DashboardBloc, DashboardState>(
                    bloc: dashboardBloc,
                    builder: (context, state) {
                      if (!state.socketConnected) {
                        return const SizedBox();
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BatteryIndicator(
                            fillLevel: _normalizeValue(1300),
                            title: 'CH1',
                          ),
                          const SizedBox(width: 8),
                          BatteryIndicator(
                            fillLevel: _normalizeValue(1500),
                            title: 'CH2',
                          ),
                          const SizedBox(width: 8),
                          BatteryIndicator(
                            fillLevel: _normalizeValue(1700),
                            title: 'CH3',
                          ),
                          const SizedBox(width: 8),
                          BatteryIndicator(
                            fillLevel: _normalizeValue(1900),
                            title: 'CH4',
                          ),
                          const SizedBox(width: 8),
                          BatteryIndicator(
                            fillLevel: _normalizeValue(2100),
                            title: 'CH5',
                          ),
                          const SizedBox(width: 8),
                          BatteryIndicator(
                            fillLevel: _normalizeValue(2300),
                            title: 'CH6',
                          ),
                          const SizedBox(width: 8),
                          BatteryIndicator(
                            fillLevel: _normalizeValue(2500),
                            title: 'CH7',
                          ),
                          const SizedBox(width: 8),
                          BatteryIndicator(
                            fillLevel: _normalizeValue(2700),
                            title: 'CH8',
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
            WindowTitleBarBox(
              child: Container(
                color: Colors.black,
                child: Row(
                  children: [
                    Expanded(
                        child: MoveWindow(
                      child: Row(
                        children: [
                          Tooltip(
                            message: 'Settings',
                            child: IconButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: SettingsScreen(
                                      dashboardBloc: dashboardBloc,
                                    ),
                                  ),
                                );
                                dashboardBloc.syncDataRover();
                              },
                              icon: const Icon(Icons.settings),
                            ),
                          ),
                          BlocBuilder<DashboardBloc, DashboardState>(
                            bloc: dashboardBloc,
                            builder: (context, state) {
                              return Tooltip(
                                message: state.activeSound
                                    ? 'Disable sound'
                                    : 'Enable sound',
                                child: IconButton(
                                  onPressed: () {
                                    dashboardBloc.add(
                                      DashboardSetActiveSoundEvent(
                                        !dashboardBloc.state.activeSound,
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    state.activeSound
                                        ? Icons.volume_up
                                        : Icons.volume_off_outlined,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )),
                    MinimizeWindowButton(),
                    MaximizeWindowButton(),
                    CloseWindowButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

double _normalizeValue(double val) {
  if (val < 1000) {
    return 0;
  }
  if (val > 2000) {
    return 100;
  }
  return ((val - 1000) / (2000 - 1000)) * 100;
}

class BatteryIndicator extends StatelessWidget {
  final double fillLevel;

  const BatteryIndicator({
    super.key,
    required this.fillLevel,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: 50,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
            Container(
              width: 50,
              height: (150 * fillLevel) / 100,
              decoration: BoxDecoration(
                color: Colors.greenAccent.shade400,
                borderRadius: BorderRadius.vertical(
                  bottom: const Radius.circular(10),
                  top: fillLevel == 100
                      ? const Radius.circular(10)
                      : Radius.zero,
                ),
              ),
            ),
          ],
        ),
        Text(
          '$title: ${fillLevel.toStringAsFixed(0)}%',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
