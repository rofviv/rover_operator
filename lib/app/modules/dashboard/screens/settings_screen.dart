import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rover_operator/app/modules/dashboard/utils/keys.dart';

import '../bloc/dashboard_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.dashboardBloc});

  final DashboardBloc dashboardBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<DashboardBloc, DashboardState>(
        bloc: dashboardBloc,
        builder: (context, state) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(controller: ipBaseControler),
                  ),
                  IconButton(
                    onPressed: () {
                      dashboardBloc
                          .add(DashboardIpRemoteEvent(ipBaseControler.text));
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.save),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Size Icon:'),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          dashboardBloc
                              .add(DashboardSizeIconEvent(state.sizeIcon - 2));
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text('${state.sizeIcon}'),
                      IconButton(
                        onPressed: () {
                          dashboardBloc
                              .add(DashboardSizeIconEvent(state.sizeIcon + 2));
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
