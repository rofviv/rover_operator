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