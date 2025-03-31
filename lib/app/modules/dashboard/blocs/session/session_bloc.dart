import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/preferences_repository.dart';
import '../../data/dtos/fetch_orders_dto.dart';
import '../../data/dtos/login_dto.dart';
import '../../data/models/order_model.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/patio_repository.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final PatioRepository _patioRepository;
  final PreferencesRepository _preferencesRepository;

  SessionBloc(this._patioRepository, this._preferencesRepository)
      : super(const SessionState()) {
    on<SessionSetUserEvent>((event, emit) =>
        emit(state.copyWith(user: event.user, isLoadingLogin: false)));
    on<SessionLogoutEvent>((event, emit) => emit(const SessionState()));
    on<OnLoadingLoginEvent>(
        (event, emit) => emit(state.copyWith(isLoadingLogin: event.isLoading)));

    on<OnSetOrdersEvent>(
        (event, emit) => emit(state.copyWith(orders: event.orders)));

    init();
  }

  void init() async {
    final user = await _patioRepository.getUserByToken();
    if (user != null) {
      add(SessionSetUserEvent(user));
      getOrdersByDriver();
    }
  }

  Future<void> getOrdersByDriver() async {
    try {
      final orders = await _patioRepository.getOrdersByDriver(
        FetchOrdersDto(
          start: DateTime.now().copyWith(hour: 0, minute: 0, second: 0),
          end: DateTime.now().copyWith(
            hour: 23,
            minute: 59,
            second: 59,
          ),
          status: "assigned,enabled",
        ),
      );
      add(OnSetOrdersEvent(orders));
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
