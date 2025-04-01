import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/preferences_repository.dart';
import '../../data/dtos/fetch_orders_dto.dart';
import '../../data/dtos/login_dto.dart';
import '../../data/models/driver_timing_model.dart';
import '../../data/models/order_model.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/patio_repository.dart';

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

    on<OnSetDriverTimingEvent>((event, emit) =>
        emit(state.copyWith(driverTiming: event.driverTiming)));

    on<OnLoadingOrdersEvent>((event, emit) =>
        emit(state.copyWith(isLoadingOrders: event.isLoading)));

    init();
  }

  void init() async {
    final user = await _patioRepository.getUserByToken();
    if (user != null) {
      add(SessionSetUserEvent(user));
      getDriverCurrentTiming();
      getOrdersByDriver();
      _timerOrders?.cancel();
      _timerOrders = Timer.periodic(const Duration(minutes: 1), (timer) {
        getOrdersByDriver();
      });
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
      print(e.toString());
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
}
