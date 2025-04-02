part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

class SessionSetUserEvent extends SessionEvent {
  final UserModel user;

  const SessionSetUserEvent(this.user);
}

class SessionLogoutEvent extends SessionEvent {}

class OnLoadingLoginEvent extends SessionEvent {
  final bool isLoading;

  const OnLoadingLoginEvent(this.isLoading);
}

class OnSetOrdersEvent extends SessionEvent {
  final List<Order> orders;

  const OnSetOrdersEvent(this.orders);
}

class OnSetDriverTimingEvent extends SessionEvent {
  final DriverTimingModel? driverTiming;

  const OnSetDriverTimingEvent(this.driverTiming);
}

class OnLoadingOrdersEvent extends SessionEvent {
  final bool isLoading;

  const OnLoadingOrdersEvent(this.isLoading);
}

class OnSetZonesEvent extends SessionEvent {
  final List<ZoneModel> zones;

  const OnSetZonesEvent(this.zones);
}

class OnSetSelectedZoneEvent extends SessionEvent {
  final ZoneModel zone;

  const OnSetSelectedZoneEvent(this.zone);
}

class OnLoadingCreateTimingEvent extends SessionEvent {
  final bool isLoading;

  const OnLoadingCreateTimingEvent(this.isLoading);
}
