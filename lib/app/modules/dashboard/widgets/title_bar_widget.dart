import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:rover_operator/app/modules/dashboard/blocs/dashboard/dashboard_bloc.dart';

import '../blocs/session/session_bloc.dart';
import '../screens/settings_screen.dart';
import '../utils/form_keys.dart';

class TitleBarWidget extends StatelessWidget {
  const TitleBarWidget(
      {super.key, required this.dashboardBloc, required this.sessionBloc});

  final DashboardBloc dashboardBloc;
  final SessionBloc sessionBloc;

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
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
                  Tooltip(
                    message: 'Account',
                    child: IconButton(
                      icon: Row(
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 5),
                          BlocBuilder<SessionBloc, SessionState>(
                            bloc: sessionBloc,
                            builder: (context, sessionState) {
                              if (sessionState.user == null) {
                                return Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                );
                              }
                              return Text(
                                "#${sessionState.user!.id} ${sessionState.user!.name}",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      onPressed: () {
                        if (sessionBloc.state.user == null) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Form(
                                key: formLoginKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: emailLoginKey,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                      ),
                                      validator: (value) {
                                        return value != null && value.isNotEmpty
                                            ? null
                                            : "Email is required";
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      controller: passwordLoginKey,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                      ),
                                      validator: (value) {
                                        return value != null && value.isNotEmpty
                                            ? null
                                            : "Password is required";
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                          onPressed: () {
                                            Modular.to.pop();
                                          },
                                        ),
                                        BlocBuilder<SessionBloc, SessionState>(
                                          bloc: sessionBloc,
                                          builder: (context, state) {
                                            return ElevatedButton(
                                              child: state.isLoadingLogin
                                                  ? CupertinoActivityIndicator()
                                                  : const Text(
                                                      'Login',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                              onPressed: state.isLoadingLogin
                                                  ? null
                                                  : () async {
                                                      if (formLoginKey
                                                          .currentState!
                                                          .validate()) {
                                                        try {
                                                          await sessionBloc.login(
                                                              emailLoginKey
                                                                  .text,
                                                              passwordLoginKey
                                                                  .text);
                                                          ;
                                                          Modular.to.pop();
                                                        } catch (e) {
                                                          sessionBloc.add(
                                                            const OnLoadingLoginEvent(
                                                                false),
                                                          );
                                                          showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                AlertDialog(
                                                              title: Text(
                                                                  e.toString()),
                                                            ),
                                                          );
                                                        }
                                                      }
                                                    },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(sessionBloc.state.user!.id?.toString() ??
                                      ""),
                                  Text(sessionBloc.state.user!.name ?? ""),
                                  Text(sessionBloc.state.user!.email ?? ""),
                                  Text(sessionBloc.state.user!.status ?? ""),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    child: Text(
                                      "Logout",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                    onPressed: () {
                                      sessionBloc.logout();
                                      Modular.to.pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Tooltip(
                    message: 'Timing',
                    child: IconButton(
                      onPressed: () {},
                      icon: Row(
                        children: [
                          const Icon(Icons.timer),
                          const SizedBox(width: 5),
                          BlocBuilder<SessionBloc, SessionState>(
                            bloc: sessionBloc,
                            builder: (context, sessionState) {
                              if (sessionState.driverTiming == null) {
                                return Text(
                                  "Timing",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                );
                              }
                              return Text(
                                "${sessionState.driverTiming!.zone} | ${DateFormat('h:mm a').format(sessionState.driverTiming!.startTiming.toLocal())} - ${DateFormat('h:mm a').format(sessionState.driverTiming!.endTiming.toLocal())}",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
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
    );
  }
}
