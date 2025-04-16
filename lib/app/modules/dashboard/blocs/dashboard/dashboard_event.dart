part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardSizeIconEvent extends DashboardEvent {
  final double sizeIcon;
  const DashboardSizeIconEvent(this.sizeIcon);
}

class DashboardLeftArrowEvent extends DashboardEvent {}

class DashboardRightArrowEvent extends DashboardEvent {}

class DashboardParkingEvent extends DashboardEvent {}

class DashboardDoorEvent extends DashboardEvent {}

class DashboardDoorBackEvent extends DashboardEvent {}

class DashboardLightEvent extends DashboardEvent {}

class DashboardClaxonEvent extends DashboardEvent {}

class DashboardRetroEvent extends DashboardEvent {}

class DashboardIpRemoteEvent extends DashboardEvent {
  final String ipRemote;
  const DashboardIpRemoteEvent(this.ipRemote);
}

class DashboardErrorMessageHostEvent extends DashboardEvent {
  final String errorMessage;
  const DashboardErrorMessageHostEvent(this.errorMessage);
}

class DashboardErrorMessageRelayEvent extends DashboardEvent {
  final String errorMessage;
  const DashboardErrorMessageRelayEvent(this.errorMessage);
}

class DashboardIsLoadingEvent extends DashboardEvent {
  final bool isLoading;
  const DashboardIsLoadingEvent(this.isLoading);
}

class DashboardIsLoadingRelayEvent extends DashboardEvent {
  final bool isLoadingRelay;
  const DashboardIsLoadingRelayEvent(this.isLoadingRelay);
}

class DashboardSetRoverStatusEvent extends DashboardEvent {
  final RoverStatusModel roverStatus;
  const DashboardSetRoverStatusEvent(this.roverStatus);
}

class DashboardSetRelayEvent extends DashboardEvent {
  final RelayModel relay;
  const DashboardSetRelayEvent(this.relay);
}

class DashboardSetRelaysMapEvent extends DashboardEvent {
  final Map<Relays, RelayAction> relaysMap;
  const DashboardSetRelaysMapEvent(this.relaysMap);
}

class DashboardSetRelaysEvent extends DashboardEvent {
  final Map<Relays, RelayAction> relaysMap;
  const DashboardSetRelaysEvent(this.relaysMap);
}

class DashboardSetDistanceSonar1Event extends DashboardEvent {
  final double distanceSonar1;
  const DashboardSetDistanceSonar1Event(this.distanceSonar1);
}

class DashboardSetDistanceSonar2Event extends DashboardEvent {
  final double distanceSonar2;
  const DashboardSetDistanceSonar2Event(this.distanceSonar2);
}

class DashboardSetDistanceSonar3Event extends DashboardEvent {
  final double distanceSonar3;
  const DashboardSetDistanceSonar3Event(this.distanceSonar3);
}

class DashboardSetDistanceSonar4Event extends DashboardEvent {
  final double distanceSonar4;
  const DashboardSetDistanceSonar4Event(this.distanceSonar4);
}

class DashboardSetActiveSoundEvent extends DashboardEvent {
  final bool activeSound;
  const DashboardSetActiveSoundEvent(this.activeSound);
}

class DashboardSetSocketConnectedEvent extends DashboardEvent {
  final bool socketConnected;
  const DashboardSetSocketConnectedEvent(this.socketConnected);
}

class DashboardSetCubeStatusEvent extends DashboardEvent {
  final CubeStatusModel cubeStatus;
  const DashboardSetCubeStatusEvent(this.cubeStatus);
}

class DashboardSetLatencyEvent extends DashboardEvent {
  final double latencyPing;
  final bool latencyAlert;
  const DashboardSetLatencyEvent(this.latencyPing, this.latencyAlert);
}

class DashboardSetMapHeightEvent extends DashboardEvent {
  final double mapHeight;
  const DashboardSetMapHeightEvent(this.mapHeight);
}

class DashboardSetDistanceLidarEvent extends DashboardEvent {
  final double distanceLidar;
  final double angleLidar;
  final bool clear;
  const DashboardSetDistanceLidarEvent(this.distanceLidar, this.angleLidar,
      {this.clear = false});
}
