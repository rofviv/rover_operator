import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rover_operator/app/modules/dashboard/data/models/user_model.dart';

import '../../../../core/preferences_repository.dart';
import '../../data/dtos/login_dto.dart';
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
    init();
  }

  void init() async {
    final user = await _patioRepository.getUserByToken();
    if (user != null) {
      add(SessionSetUserEvent(user));
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
