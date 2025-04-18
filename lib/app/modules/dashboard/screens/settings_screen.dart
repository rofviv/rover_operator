import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rover_operator/app/modules/dashboard/utils/keys.dart';

import '../blocs/dashboard/dashboard_bloc.dart';
import '../utils/relays_data.dart';

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
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: ipRemoteControler,
                        decoration: const InputDecoration(
                          labelText: 'IP Remote',
                          hintText: '10.13.13.1',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        dashboardBloc.add(
                            DashboardIpRemoteEvent(ipRemoteControler.text));
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.save),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Size Icon:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            dashboardBloc.add(
                                DashboardSizeIconEvent(state.sizeIcon - 2));
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text('${state.sizeIcon}'),
                        IconButton(
                          onPressed: () {
                            dashboardBloc.add(
                                DashboardSizeIconEvent(state.sizeIcon + 2));
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Lidar Height:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            dashboardBloc.add(DashboardSetLidarHeightEvent(
                                state.lidarHeight - 10));
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text('${state.lidarHeight}'),
                        IconButton(
                          onPressed: () {
                            dashboardBloc.add(DashboardSetLidarHeightEvent(
                                state.lidarHeight + 10));
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    )
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Map Height:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            dashboardBloc.add(DashboardSetMapHeightEvent(
                                state.mapHeight - 10));
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text('${state.mapHeight}'),
                        IconButton(
                          onPressed: () {
                            dashboardBloc.add(DashboardSetMapHeightEvent(
                                state.mapHeight + 10));
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    )
                  ],
                ),
                const Divider(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Action'),
                    Text('Relay'),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Relays.leftArrow.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<int>(
                      value: state.relaysMap[Relays.leftArrow]?.relay,
                      items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                          .map(
                            (e) => DropdownMenuItem<int>(
                              value: e,
                              child: Text('$e'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        dashboardBloc.setRelays(Relays.leftArrow, value ?? 0);
                      },
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Relays.rightArrow.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<int>(
                      value: state.relaysMap[Relays.rightArrow]?.relay,
                      items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                          .map(
                            (e) => DropdownMenuItem<int>(
                              value: e,
                              child: Text('$e'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        dashboardBloc.setRelays(Relays.rightArrow, value ?? 0);
                      },
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Relays.door.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<int>(
                      value: state.relaysMap[Relays.door]?.relay,
                      items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                          .map(
                            (e) => DropdownMenuItem<int>(
                              value: e,
                              child: Text('$e'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        dashboardBloc.setRelays(Relays.door, value ?? 0);
                      },
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Relays.doorBack.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<int>(
                      value: state.relaysMap[Relays.doorBack]?.relay,
                      items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                          .map(
                            (e) => DropdownMenuItem<int>(
                              value: e,
                              child: Text('$e'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        dashboardBloc.setRelays(Relays.doorBack, value ?? 0);
                      },
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Relays.light.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<int>(
                      value: state.relaysMap[Relays.light]?.relay,
                      items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                          .map(
                            (e) => DropdownMenuItem<int>(
                              value: e,
                              child: Text('$e'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        dashboardBloc.setRelays(Relays.light, value ?? 0);
                      },
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Relays.claxon.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<int>(
                      value: state.relaysMap[Relays.claxon]?.relay,
                      items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                          .map(
                            (e) => DropdownMenuItem<int>(
                              value: e,
                              child: Text('$e'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        dashboardBloc.setRelays(Relays.claxon, value ?? 0);
                      },
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Relays.retro.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<int>(
                      value: state.relaysMap[Relays.retro]?.relay,
                      items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                          .map(
                            (e) => DropdownMenuItem<int>(
                              value: e,
                              child: Text('$e'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        dashboardBloc.setRelays(Relays.retro, value ?? 0);
                      },
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Lidar distance',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<String>(
                      value: state.roverStatus.lidarDistance ?? "0",
                      items: [
                        '0',
                        '1000',
                        '1500',
                        '2000',
                        '2500',
                        '3000',
                        '3500',
                        '4000',
                        '4500',
                        '5000',
                        '5500',
                        '6000',
                        '6500',
                        '7000',
                        '7500',
                        '8000',
                        '8500',
                        '9000',
                        '9500',
                        '10000'
                      ]
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        dashboardBloc.setLidarDistance(value ?? "0");
                      },
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Lidar angle',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<String>(
                      value: state.roverStatus.lidarAngle ?? "0",
                      items: [
                        '0',
                        '45',
                        '90',
                        '135',
                        '180',
                        '225',
                        '270',
                        '315',
                        '360'
                      ]
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        dashboardBloc.setLidarAngle(value ?? "0");
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
