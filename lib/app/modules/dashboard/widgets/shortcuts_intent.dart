import 'package:flutter/material.dart';

import '../blocs/dashboard/dashboard_bloc.dart';

// Intents

class LeftArrowIntent extends Intent {}

class RightArrowIntent extends Intent {}

class ParkingIntent extends Intent {}

class DoorIntent extends Intent {}

class DoorBackIntent extends Intent {}

class LightIntent extends Intent {}

class ClaxonIntent extends Intent {}

class RetroIntent extends Intent {}

// Actions

class LeftArrowAction extends Action<LeftArrowIntent> {
  final DashboardBloc dashboardBloc;
  LeftArrowAction({required this.dashboardBloc});

  @override
  void invoke(covariant LeftArrowIntent intent) {
    dashboardBloc.add(DashboardLeftArrowEvent());
  }
}

class RightArrowAction extends Action<RightArrowIntent> {
  final DashboardBloc dashboardBloc;
  RightArrowAction({required this.dashboardBloc});

  @override
  void invoke(covariant RightArrowIntent intent) {
    dashboardBloc.add(DashboardRightArrowEvent());
  }
}

class ParkingAction extends Action<ParkingIntent> {
  final DashboardBloc dashboardBloc;
  ParkingAction({required this.dashboardBloc});

  @override
  void invoke(covariant ParkingIntent intent) {
    dashboardBloc.add(DashboardParkingEvent());
  }
}

class DoorAction extends Action<DoorIntent> {
  final DashboardBloc dashboardBloc;
  DoorAction({required this.dashboardBloc});

  @override
  void invoke(covariant DoorIntent intent) {
    dashboardBloc.add(DashboardDoorEvent());
  }
}

class DoorBackAction extends Action<DoorBackIntent> {
  final DashboardBloc dashboardBloc;
  DoorBackAction({required this.dashboardBloc});

  @override
  void invoke(covariant DoorBackIntent intent) {
    dashboardBloc.add(DashboardDoorBackEvent());
  }
}

class LightAction extends Action<LightIntent> {
  final DashboardBloc dashboardBloc;
  LightAction({required this.dashboardBloc});

  @override
  void invoke(covariant LightIntent intent) {
    dashboardBloc.add(DashboardLightEvent());
  }
}

class ClaxonAction extends Action<ClaxonIntent> {
  final DashboardBloc dashboardBloc;
  ClaxonAction({required this.dashboardBloc});

  @override
  void invoke(covariant ClaxonIntent intent) {
    dashboardBloc.add(DashboardClaxonEvent());
  }
}

class RetroAction extends Action<RetroIntent> {
  final DashboardBloc dashboardBloc;
  RetroAction({required this.dashboardBloc});

  @override
  void invoke(covariant RetroIntent intent) {
    dashboardBloc.add(DashboardRetroEvent());
  }
}
