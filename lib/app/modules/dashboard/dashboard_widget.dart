import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'blocs/dashboard/dashboard_bloc.dart';
import 'blocs/location/location_bloc.dart';
import 'blocs/session/session_bloc.dart';
import 'utils/payment_type.dart';
import 'widgets/dashboard_actions_widget.dart';
import 'widgets/map_widget.dart';
import 'widgets/title_bar_widget.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget(
      {super.key,
      required this.dashboardBloc,
      required this.locationBloc,
      required this.sessionBloc});

  final DashboardBloc dashboardBloc;
  final LocationBloc locationBloc;
  final SessionBloc sessionBloc;

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
                  const SizedBox(height: 30),
                  DashboardActionsWidget(dashboardBloc: dashboardBloc),
                  // const SizedBox(height: 20),
                  // BlocBuilder<DashboardBloc, DashboardState>(
                  //   bloc: dashboardBloc,
                  //   builder: (context, state) {
                  //     return Stack(
                  //       clipBehavior: Clip.none,
                  //       children: [
                  //         Image.asset(
                  //           "assets/icons/patioRobot.png",
                  //           width: 300,
                  //           height: 300,
                  //           fit: BoxFit.cover,
                  //           color: state.socketConnected
                  //               ? null
                  //               : Colors.grey.shade800,
                  //         ),
                  //         if (state.distanceSonar1 > 0)
                  //           Positioned(
                  //             left: 0,
                  //             child: Container(
                  //               width: 50,
                  //               height: 5,
                  //               color: Colors.red,
                  //             ),
                  //           ),
                  //         if (state.distanceSonar2 > 0)
                  //           Positioned(
                  //             left: 0,
                  //             right: 0,
                  //             child: Center(
                  //               child: Container(
                  //                 width: 50,
                  //                 height: 5,
                  //                 color: Colors.red,
                  //               ),
                  //             ),
                  //           ),
                  //         if (state.distanceSonar3 > 0)
                  //           Positioned(
                  //             right: 0,
                  //             child: Container(
                  //               width: 50,
                  //               height: 5,
                  //               color: Colors.red,
                  //             ),
                  //           ),
                  //         if (state.distanceSonar4 > 0)
                  //           Positioned(
                  //             left: 0,
                  //             right: 0,
                  //             bottom: 0,
                  //             child: Center(
                  //               child: Container(
                  //                 width: 50,
                  //                 height: 5,
                  //                 color: Colors.red,
                  //               ),
                  //             ),
                  //           ),
                  //         Positioned(
                  //           top: 0,
                  //           left: -20,
                  //           bottom: 0,
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Text(
                  //                 state.cubeStatus.armadoStr ?? '',
                  //                 style: TextStyle(
                  //                   color: state.cubeStatus.armadoStr == "ARMED"
                  //                       ? Colors.green
                  //                       : Colors.red,
                  //                   fontSize: 20,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //               ),
                  //               Text(
                  //                 state.cubeStatus.mode ?? '',
                  //                 style: const TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 18,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // ),
                  // const SizedBox(height: 50),
                  // BlocBuilder<DashboardBloc, DashboardState>(
                  //   bloc: dashboardBloc,
                  //   builder: (context, state) {
                  //     if (!state.socketConnected) {
                  //       return const SizedBox();
                  //     }
                  //     return Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         BatteryIndicator(
                  //           fillLevel: _normalizeValue(1300),
                  //           title: 'CH1',
                  //         ),
                  //         const SizedBox(width: 8),
                  //         BatteryIndicator(
                  //           fillLevel: _normalizeValue(1500),
                  //           title: 'CH2',
                  //         ),
                  //         const SizedBox(width: 8),
                  //         BatteryIndicator(
                  //           fillLevel: _normalizeValue(1700),
                  //           title: 'CH3',
                  //         ),
                  //         const SizedBox(width: 8),
                  //         BatteryIndicator(
                  //           fillLevel: _normalizeValue(1900),
                  //           title: 'CH4',
                  //         ),
                  //         const SizedBox(width: 8),
                  //         BatteryIndicator(
                  //           fillLevel: _normalizeValue(2100),
                  //           title: 'CH5',
                  //         ),
                  //         const SizedBox(width: 8),
                  //         BatteryIndicator(
                  //           fillLevel: _normalizeValue(2300),
                  //           title: 'CH6',
                  //         ),
                  //         const SizedBox(width: 8),
                  //         BatteryIndicator(
                  //           fillLevel: _normalizeValue(2500),
                  //           title: 'CH7',
                  //         ),
                  //         const SizedBox(width: 8),
                  //         BatteryIndicator(
                  //           fillLevel: _normalizeValue(2700),
                  //           title: 'CH8',
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // ),
                  BlocBuilder<DashboardBloc, DashboardState>(
                    bloc: dashboardBloc,
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          state.cubeStatus.armadoStr == null
                              ? const Text(
                                  "-",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                )
                              : state.cubeStatus.armadoStr == "ARMED"
                                  ? Text(
                                      state.cubeStatus.armadoStr ?? '',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    )
                                  : Text(
                                      state.cubeStatus.armadoStr ?? '-',
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    )
                                      .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true),
                                      )
                                      .fadeOut(
                                        delay: 200.milliseconds,
                                      ),
                          const SizedBox(
                            height: 20,
                            child: VerticalDivider(
                              thickness: 2,
                              color: Colors.grey,
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
                          const SizedBox(
                            height: 20,
                            child: VerticalDivider(
                              thickness: 2,
                              color: Colors.grey,
                            ),
                          ),
                          if (state.roverStatus.latencyStatus == "1")
                            Text(
                              "${state.currentLatencyPing} ms.",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  BlocBuilder<DashboardBloc, DashboardState>(
                    bloc: dashboardBloc,
                    builder: (context, state) {
                      return Stack(
                        children: [
                          Container(
                            height: 600,
                            decoration: BoxDecoration(
                              border: !state.socketConnected
                                  ? Border.all(
                                      color: Colors.red,
                                      width: 10,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                    )
                                  : null,
                            ),
                            child: MapWidget(
                              locationBloc: locationBloc,
                              dashboardBloc: dashboardBloc,
                              sessionBloc: sessionBloc,
                            ),
                          ),
                          if (state.distanceSonar1 > 0)
                            Positioned(
                              top: -200,
                              left: -200,
                              child: Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.red.withValues(alpha: 0.5),
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.red,
                                      blurRadius: 100,
                                    ),
                                  ],
                                ),
                              )
                                  .animate(
                                    onPlay: (controller) => controller.repeat(),
                                  )
                                  .fadeOut(
                                    duration: 1000.milliseconds,
                                  ),
                            ),
                          if (state.distanceSonar2 > 0)
                            Positioned(
                              top: -250,
                              right: 200,
                              left: 200,
                              child: Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.red.withValues(alpha: 0.5),
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.red,
                                      blurRadius: 100,
                                    ),
                                  ],
                                ),
                              )
                                  .animate(
                                    onPlay: (controller) => controller.repeat(),
                                  )
                                  .fadeOut(
                                    duration: 1000.milliseconds,
                                  ),
                            ),
                          if (state.distanceSonar3 > 0)
                            Positioned(
                              top: -200,
                              right: -200,
                              child: Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.red.withValues(alpha: 0.5),
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.red,
                                      blurRadius: 100,
                                    ),
                                  ],
                                ),
                              )
                                  .animate(
                                    onPlay: (controller) => controller.repeat(),
                                  )
                                  .fadeOut(
                                    duration: 1000.milliseconds,
                                  ),
                            ),
                          if (state.distanceSonar4 > 0)
                            Positioned(
                              bottom: -250,
                              right: 200,
                              left: 200,
                              child: Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.red.withValues(alpha: 0.5),
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.red,
                                      blurRadius: 100,
                                    ),
                                  ],
                                ),
                              )
                                  .animate(
                                    onPlay: (controller) => controller.repeat(),
                                  )
                                  .fadeOut(
                                    duration: 1000.milliseconds,
                                  ),
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  const SizedBox(width: 15),
                  BlocBuilder<SessionBloc, SessionState>(
                    bloc: sessionBloc,
                    builder: (context, state) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Total Orders: ${state.orders.length}",
                                  style: const TextStyle(color: Colors.white)),
                              const SizedBox(
                                width: 5,
                              ),
                              !state.isLoadingOrders
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.refresh,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        sessionBloc.getOrdersByDriver();
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.refresh,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        //
                                      },
                                    )
                                      .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(),
                                      )
                                      .rotate(
                                        delay: 200.milliseconds,
                                      ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 15),
                                ...state.orders.map(
                                  (order) => GestureDetector(
                                    onTap: () {
                                      if (order.status.contains("pending") ||
                                          order.status.contains("assigned") ||
                                          order.status.contains("arrived")) {
                                        locationBloc.goTo(order.fromLatitude,
                                            order.fromLongitude);
                                      } else {
                                        locationBloc.goTo(order.toLatitude,
                                            order.toLongitude);
                                      }
                                    },
                                    onSecondaryTap: () {
                                      if (order.status.contains("pending") ||
                                          order.status.contains("assigned") ||
                                          order.status.contains("arrived")) {
                                        locationBloc.goTo(order.toLatitude,
                                            order.toLongitude);
                                      } else {
                                        locationBloc.goTo(order.fromLatitude,
                                            order.fromLongitude);
                                      }
                                    },
                                    child: Container(
                                      width: 250,
                                      margin: const EdgeInsets.only(right: 15),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 10,
                                            offset: Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SelectableText(
                                                  "ID: #${order.id.toString()}"),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(11),
                                                decoration: BoxDecoration(
                                                  color: order.color,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text("Name: ${order.nameUser}"),
                                          Text("Phone: ${order.phoneUser}"),
                                          const Divider(),
                                          Text("From: ${order.merchantName}"),
                                          Text("${order.fromAddress}"),
                                          const Divider(),
                                          Text("To: ${order.toAddress}"),
                                          const Divider(),
                                          TextButton(
                                            onPressed: () async {
                                              if (order.urlImageReference !=
                                                  null) {
                                                await launchUrl(
                                                  Uri.parse(
                                                    order.urlImageReference!,
                                                  ),
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                );
                                              } else {
                                                //
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Text("Details"),
                                                SizedBox(width: 5),
                                                Icon(Icons.exit_to_app),
                                              ],
                                            ),
                                          ),
                                          const Divider(),
                                          Text(
                                              "Payment type: ${paymentNameById(order.paymentModeId)}"),
                                          Text("Subtotal: ${order.total}"),
                                          Text(
                                              "Delivery cost: ${order.baseCost}"),
                                          Text(
                                              "Fee merchat: ${order.feeMerchant}"),
                                          Text(
                                              "Total: ${order.total + order.baseCost + order.feeMerchant}"),
                                          const Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Status: ${order.status}"),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  foregroundColor: Colors.white,
                                                ),
                                                onPressed: () {},
                                                child: const Text("Accept"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
                ],
              ),
            ),
            TitleBarWidget(
              dashboardBloc: dashboardBloc,
              sessionBloc: sessionBloc,
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
