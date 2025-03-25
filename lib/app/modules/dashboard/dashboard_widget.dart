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
        body: Column(
          children: [
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
            DashboardActionsWidget(dashboardBloc: dashboardBloc),
            BlocBuilder<DashboardBloc, DashboardState>(
              bloc: dashboardBloc,
              builder: (context, state) {
                return Stack(
                  children: [
                    Image.asset("assets/icons/patioRobot.png",
                        width: 350, height: 350),
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
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
