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
