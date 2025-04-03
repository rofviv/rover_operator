part of 'session_bloc.dart';

class SessionState extends Equatable {
  final UserModel? user;
  final bool isLoadingLogin;
  final bool isLoadingOrders;
  final List<Order> orders;
  final DriverTimingModel? driverTiming;
  final List<ZoneModel> zones;
  final ZoneModel? selectedZone;
  final bool isLoadingCreateTiming;
  final bool isLoadingUpdateOrder;

  const SessionState({
    this.user,
    this.isLoadingLogin = false,
    this.isLoadingOrders = false,
    this.orders = const [],
    this.driverTiming,
    this.zones = const [],
    this.selectedZone,
    this.isLoadingCreateTiming = false,
    this.isLoadingUpdateOrder = false,
  });

  SessionState copyWith({
    UserModel? user,
    bool? isLoadingLogin,
    bool? isLoadingOrders,
    List<Order>? orders,
    DriverTimingModel? driverTiming,
    bool clearDriverTiming = false,
    List<ZoneModel>? zones,
    ZoneModel? selectedZone,
    bool? isLoadingCreateTiming,
    bool? isLoadingUpdateOrder,
  }) =>
      SessionState(
        user: user ?? this.user,
        isLoadingLogin: isLoadingLogin ?? this.isLoadingLogin,
        isLoadingOrders: isLoadingOrders ?? this.isLoadingOrders,
        orders: orders ?? this.orders,
        driverTiming: clearDriverTiming ? null : driverTiming ?? this.driverTiming,
        zones: zones ?? this.zones,
        selectedZone: selectedZone ?? this.selectedZone,
        isLoadingCreateTiming: isLoadingCreateTiming ?? this.isLoadingCreateTiming,
        isLoadingUpdateOrder: isLoadingUpdateOrder ?? this.isLoadingUpdateOrder,
      );

  @override
  List<Object?> get props => [
        user,
        isLoadingLogin,
        isLoadingOrders,
        orders,
        driverTiming,
        zones,
        selectedZone,
        isLoadingCreateTiming,
        isLoadingUpdateOrder,
      ];
}
