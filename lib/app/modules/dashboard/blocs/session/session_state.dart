part of 'session_bloc.dart';

class SessionState extends Equatable {
  final UserModel? user;
  final bool isLoadingLogin;
  final bool isLoadingOrders;
  final List<Order> orders;
  final DriverTimingModel? driverTiming;

  const SessionState({
    this.user,
    this.isLoadingLogin = false,
    this.isLoadingOrders = false,
    this.orders = const [],
    this.driverTiming,
  });

  SessionState copyWith({
    UserModel? user,
    bool? isLoadingLogin,
    bool? isLoadingOrders,
    List<Order>? orders,
    DriverTimingModel? driverTiming,
  }) =>
      SessionState(
        user: user ?? this.user,
        isLoadingLogin: isLoadingLogin ?? this.isLoadingLogin,
        isLoadingOrders: isLoadingOrders ?? this.isLoadingOrders,
        orders: orders ?? this.orders,
        driverTiming: driverTiming ?? this.driverTiming,
      );

  @override
  List<Object?> get props => [
        user,
        isLoadingLogin,
        isLoadingOrders,
        orders,
        driverTiming,
      ];
}
