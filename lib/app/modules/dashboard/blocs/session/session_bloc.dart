import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/preferences_repository.dart';
import '../../data/dtos/create_timing_dto.dart';
import '../../data/dtos/fetch_orders_dto.dart';
import '../../data/dtos/login_dto.dart';
import '../../data/dtos/update_order.dto.dart';
import '../../data/dtos/update_user_dto.dart';
import '../../data/models/driver_timing_model.dart';
import '../../data/models/order_model.dart';
import '../../data/models/user_model.dart';
import '../../data/models/zone_model.dart';
import '../../data/repositories/patio_repository.dart';
import '../../utils/form_keys.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final PatioRepository _patioRepository;
  final PreferencesRepository _preferencesRepository;

  Timer? _timerOrders;

  SessionBloc(this._patioRepository, this._preferencesRepository)
      : super(const SessionState()) {
    on<SessionSetUserEvent>((event, emit) =>
        emit(state.copyWith(user: event.user, isLoadingLogin: false)));
    on<SessionLogoutEvent>((event, emit) => emit(const SessionState()));
    on<OnLoadingLoginEvent>(
        (event, emit) => emit(state.copyWith(isLoadingLogin: event.isLoading)));

    on<OnSetOrdersEvent>((event, emit) =>
        emit(state.copyWith(orders: event.orders, isLoadingOrders: false)));

    on<OnSetDriverTimingEvent>((event, emit) => emit(state.copyWith(
        driverTiming: event.driverTiming,
        clearDriverTiming: event.driverTiming == null)));

    on<OnLoadingOrdersEvent>((event, emit) =>
        emit(state.copyWith(isLoadingOrders: event.isLoading)));

    on<OnSetZonesEvent>(
        (event, emit) => emit(state.copyWith(zones: event.zones)));

    on<OnSetSelectedZoneEvent>(
        (event, emit) => emit(state.copyWith(selectedZone: event.zone)));

    on<OnLoadingCreateTimingEvent>((event, emit) =>
        emit(state.copyWith(isLoadingCreateTiming: event.isLoading)));

    on<OnLoadingUpdateOrderEvent>((event, emit) =>
        emit(state.copyWith(isLoadingUpdateOrder: event.isLoading)));

    init();
  }

  void init() async {
    final user = await _patioRepository.getUserByToken();
    if (user != null) {
      add(SessionSetUserEvent(user));
      getDriverCurrentTiming();
      getOrdersByDriver();
      _timerOrders?.cancel();
      _timerOrders = Timer.periodic(const Duration(minutes: 3), (timer) {
        getOrdersByDriver();
      });
      await Future.delayed(const Duration(seconds: 1));
      getZones();
    }
  }

  Future<void> getOrdersByDriver() async {
    try {
      add(const OnLoadingOrdersEvent(true));
      final orders = await _patioRepository.getOrdersByDriver(
        FetchOrdersDto(
          status: "assigned",
        ),
      );
      List<Order> ordersList = [];
      for (var i = 0; i < orders.length; i++) {
        final order = orders[i];
        order.color = Order.getColorRandom(i);
        ordersList.add(order);
      }
      add(OnSetOrdersEvent(ordersList));
    } catch (e) {
      add(const OnLoadingOrdersEvent(false));
      print(e.toString());
    }
  }

  Future<void> getDriverCurrentTiming() async {
    try {
      final timing = await _patioRepository.getDriverCurrentTiming();
      if (timing != null) {
        add(OnSetDriverTimingEvent(timing));
      }
    } catch (e) {
      add(const OnSetDriverTimingEvent(null));
    }
  }

  Future<void> login(String email, String password) async {
    add(const OnLoadingLoginEvent(true));
    final user = await _patioRepository
        .login(LoginDto(email: email, password: password));
    add(SessionSetUserEvent(user));
  }

  void logout() {
    _preferencesRepository.clearSession();
    add(SessionLogoutEvent());
  }

  Future<void> createTiming() async {
    try {
      add(const OnLoadingCreateTimingEvent(true));
      await _patioRepository.createTiming(
        CreateTimingDto(
          startTiming: DateTime.parse(startTimingKey.text),
          endTiming: DateTime.parse(endTimingKey.text),
          limitTiming: 1,
          modalityId: state.user!.modalityId,
          zoneId: state.selectedZone!.id,
          extraAmount: 0,
          bonus: 0,
          userId: state.user!.id,
          description: "Create from rover operator",
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
      getDriverCurrentTiming();
      add(const OnLoadingCreateTimingEvent(false));
    } catch (e) {
      add(const OnLoadingCreateTimingEvent(false));
      rethrow;
    }
  }

  Future<void> getZones() async {
    final zones = await _patioRepository.getZonesByCityId(state.user!.cityId);
    add(OnSetZonesEvent(zones));
  }

  Future<void> updateStatusOrder(int driverOrderId, String status) async {
    try {
      add(const OnLoadingUpdateOrderEvent(true));
      await _patioRepository.updateStatusOrder(driverOrderId, status);
      await getOrdersByDriver();
      add(const OnLoadingUpdateOrderEvent(false));
    } catch (e) {
      add(const OnLoadingUpdateOrderEvent(false));
      rethrow;
    }
  }

  Future<void> updateOrder(int orderId, UpdateOrderDto dto) async {
    try {
      add(const OnLoadingUpdateOrderEvent(true));
      await _patioRepository.updateOrder(orderId, dto);
      await getOrdersByDriver();
      add(const OnLoadingUpdateOrderEvent(false));
    } catch (e) {
      add(const OnLoadingUpdateOrderEvent(false));
      rethrow;
    }
  }

  Future<void> confirmOrder(int driverOrderId) async {
    try {
      add(const OnLoadingUpdateOrderEvent(true));
      await _patioRepository.confirmOrder(driverOrderId);
      await getOrdersByDriver();
      add(const OnLoadingUpdateOrderEvent(false));
    } catch (e) {
      add(const OnLoadingUpdateOrderEvent(false));
      rethrow;
    }
  }

  Future<void> confirmDropoff(int orderId) async {
    try {
      add(const OnLoadingUpdateOrderEvent(true));
      await _patioRepository.confirmDropoff(orderId);
      await getOrdersByDriver();
      add(const OnLoadingUpdateOrderEvent(false));
    } catch (e) {
      add(const OnLoadingUpdateOrderEvent(false));
      rethrow;
    }
  }

  Future<void> updateUser(UpdateUserDto dto) async {
    await _patioRepository.updateUser(state.user!.id, dto);
  }
}
