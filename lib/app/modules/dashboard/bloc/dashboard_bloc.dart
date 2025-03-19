import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/helpers/audio_helper.dart';
import '../data/rover_repository.dart';
import '../utils/audio_key.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final RoverRepository roverRepository;
  Timer? _timer;

  DashboardBloc(this.roverRepository) : super(const DashboardState()) {
    on<DashboardSizeIconEvent>((event, emit) {
      emit(state.copyWith(sizeIcon: event.sizeIcon));
    });
    on<DashboardLeftArrowEvent>((event, emit) {
      if (!state.parking) {
        if (state.rightArrow) {
          audioRightArrow.stopAudio();
          emit(state.copyWith(leftArrow: !state.leftArrow, rightArrow: false));
        } else {
          emit(state.copyWith(leftArrow: !state.leftArrow));
        }
        _playAudio(state.leftArrow, audioLeftArrow);
      }
    });
    on<DashboardRightArrowEvent>((event, emit) {
      if (!state.parking) {
        if (state.leftArrow) {
          audioLeftArrow.stopAudio();
          emit(state.copyWith(rightArrow: !state.rightArrow, leftArrow: false));
        } else {
          emit(state.copyWith(rightArrow: !state.rightArrow));
        }
        _playAudio(state.rightArrow, audioRightArrow);
      }
    });
    on<DashboardParkingEvent>((event, emit) {
      emit(state.copyWith(
          parking: !state.parking,
          leftArrow: !state.parking,
          rightArrow: !state.parking));
      audioLeftArrow.stopAudio();
      audioRightArrow.stopAudio();
      _playAudio(state.parking, audioParking);
    });
    on<DashboardDoorEvent>((event, emit) {
      emit(state.copyWith(door: !state.door));
      _playAudio(state.door, audioDoor);
    });
    on<DashboardLightEvent>((event, emit) {
      emit(state.copyWith(light: !state.light));
      _playAudio(state.light, audioLight);
    });
    on<DashboardClaxonEvent>((event, emit) {
      emit(state.copyWith(claxon: !state.claxon));
      _playAudio(state.claxon, audioClaxon);
    });
    on<DashboardRetroEvent>((event, emit) {
      emit(state.copyWith(retro: !state.retro));
      _playAudio(state.retro, audioRetro);
    });
    on<DashboardSyncEvent>((event, emit) {
      emit(state.copyWith(lastSync: DateTime.now()));
    });
    on<DashboardIpRemoteEvent>((event, emit) {
      emit(state.copyWith(ipRemote: event.ipRemote));
    });
    on<DashboardErrorMessageEvent>((event, emit) {
      emit(state.copyWith(errorMessage: event.errorMessage));
    });
    on<DashboardIsLoadingEvent>((event, emit) {
      emit(state.copyWith(isLoading: event.isLoading));
    });
    syncDataRover();
  }

  void syncDataRover() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      getAllDataRover();
    });
    getAllDataRover();
  }

  Future<void> getAllDataRover() async {
    try {
      add(const DashboardIsLoadingEvent(true));
      add(const DashboardErrorMessageEvent(''));
      final relay = await roverRepository.getRelayRover(state.ipRemote);
      // TODO: update relay DATA
      add(DashboardSyncEvent());
    } catch (e) {
      add(DashboardErrorMessageEvent(e.toString()));
    } finally {
      add(const DashboardIsLoadingEvent(false));
    }
  }

  Future<void> toggleRelayRover(String relayNumber) async {
    try {
      // TODO: RELAY NUMBER modificable por el usuario
      final status = await roverRepository.toggleRelayRover(state.ipRemote, relayNumber);
      // TODO: update relay DATA
    } catch (e) {
      add(DashboardErrorMessageEvent(e.toString()));
    }
  }

  void _playAudio(bool isActive, AudioHelper audioHelper) {
    if (isActive) {
      audioHelper.playAudio();
    } else {
      audioHelper.stopAudio();
    }
  }
}
