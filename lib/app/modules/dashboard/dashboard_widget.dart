import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

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
                                dashboardBloc.getStatusRover();
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
          ],
        ),
      ),
    );
  }
}
