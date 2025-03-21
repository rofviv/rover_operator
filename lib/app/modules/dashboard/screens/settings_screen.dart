import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rover_operator/app/modules/dashboard/utils/keys.dart';

import '../bloc/dashboard_bloc.dart';
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
                Row(
                  children: [
                    Expanded(
                      child: TextField(controller: ipRemoteControler),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Size Icon:'),
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
                    Text(Relays.leftArrow.name),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            dashboardBloc.setRelays(
                                Relays.leftArrow,
                                (state.relaysMap[Relays.leftArrow]?.relay ??
                                        0) -
                                    1);
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(state.relaysMap[Relays.leftArrow]?.relay
                                .toString() ??
                            ''),
                        IconButton(
                          onPressed: () {
                            dashboardBloc.setRelays(
                                Relays.leftArrow,
                                (state.relaysMap[Relays.leftArrow]?.relay ??
                                        0) +
                                    1);
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
                    Text(Relays.leftArrow.name),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            dashboardBloc.setRelays(
                                Relays.rightArrow,
                                (state.relaysMap[Relays.rightArrow]?.relay ??
                                        0) -
                                    1);
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(state.relaysMap[Relays.rightArrow]?.relay
                                .toString() ??
                            ''),
                        IconButton(
                          onPressed: () {
                            dashboardBloc.setRelays(
                                Relays.rightArrow,
                                (state.relaysMap[Relays.rightArrow]?.relay ??
                                        0) +
                                    1);
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
                    Text(Relays.door.name),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            dashboardBloc.setRelays(Relays.door,
                                (state.relaysMap[Relays.door]?.relay ?? 0) - 1);
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(state.relaysMap[Relays.door]?.relay.toString() ??
                            ''),
                        IconButton(
                          onPressed: () {
                            dashboardBloc.setRelays(Relays.door,
                                (state.relaysMap[Relays.door]?.relay ?? 0) + 1);
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
                    Text(Relays.light.name),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            dashboardBloc.setRelays(
                                Relays.light,
                                (state.relaysMap[Relays.light]?.relay ?? 0) -
                                    1);
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(state.relaysMap[Relays.light]?.relay.toString() ??
                            ''),
                        IconButton(
                          onPressed: () {
                            dashboardBloc.setRelays(
                                Relays.light,
                                (state.relaysMap[Relays.light]?.relay ?? 0) +
                                    1);
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
                    Text(Relays.claxon.name),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            dashboardBloc.setRelays(
                                Relays.claxon,
                                (state.relaysMap[Relays.claxon]?.relay ?? 0) -
                                    1);
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(state.relaysMap[Relays.claxon]?.relay.toString() ??
                            ''),
                        IconButton(
                          onPressed: () {
                            dashboardBloc.setRelays(
                                Relays.claxon,
                                (state.relaysMap[Relays.claxon]?.relay ?? 0) +
                                    1);
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
                    Text(Relays.retro.name),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            dashboardBloc.setRelays(
                                Relays.retro,
                                (state.relaysMap[Relays.retro]?.relay ?? 0) -
                                    1);
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(state.relaysMap[Relays.retro]?.relay.toString() ??
                            ''),
                        IconButton(
                          onPressed: () {
                            dashboardBloc.setRelays(
                                Relays.retro,
                                (state.relaysMap[Relays.retro]?.relay ?? 0) +
                                    1);
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
