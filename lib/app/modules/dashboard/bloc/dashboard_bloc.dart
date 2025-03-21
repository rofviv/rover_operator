import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rover_operator/app/modules/dashboard/utils/keys.dart';
import '../../../core/helpers/audio_helper.dart';
import '../data/relay_model.dart';
import '../data/relay_action.dart';
import '../data/rover_repository.dart';
import '../data/rover_status_mode.dart';
import '../utils/audio_key.dart';
import '../utils/relays_data.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final RoverRepository roverRepository;
  Timer? _timer;

  DashboardBloc(this.roverRepository)
      : super(
          DashboardState(
            relaysMap: relaysMap,
            // leftArrow: RelayAction(id: "leftArrow", name: "Left Arrow", audio: audioLeftArrow, relay: 1, shortcut: "ALT + LEFT"),
            roverStatus: RoverStatusModel(),
            relay: RelayModel(),
          ),
        ) {
    on<DashboardSizeIconEvent>((event, emit) {
      emit(state.copyWith(sizeIcon: event.sizeIcon));
    });
    on<DashboardLeftArrowEvent>((event, emit) {
      if (!state.parking) {
        final map = {...state.relaysMap};
        map[Relays.leftArrow] = map[Relays.leftArrow]!
            .copyWith(status: !map[Relays.leftArrow]!.status);
        if (state.rightArrow) {
          audioRightArrow.stopAudio();

          emit(state.copyWith(relaysMap: map, rightArrow: false));
          // emit(state.copyWith(leftArrow: state.leftArrow.copyWith(status: true), rightArrow: false));
          toggleRelayRover(state.relayRightArrow.toString());
        } else {
          emit(state.copyWith(relaysMap: map));
          // emit(state.copyWith(leftArrow: state.leftArrow.copyWith(status: !state.leftArrow.status)));
        }
        // toggleRelayRover(state.leftArrow.relay.toString());
        toggleRelayRover(map[Relays.leftArrow]!.relay.toString());
        // _playAudio(state.leftArrow.status, state.leftArrow.audio);
        _playAudio(map[Relays.leftArrow]!.status, map[Relays.leftArrow]!.audio);
      }
    });
    on<DashboardRightArrowEvent>((event, emit) {
      if (!state.parking) {
        final map = {...state.relaysMap};
        // // if (state.leftArrow.status) {
        if (map[Relays.leftArrow]!.status) {
          map[Relays.leftArrow]!.audio.stopAudio();
          //   state.leftArrow.audio.stopAudio();
          map[Relays.leftArrow] =
              map[Relays.leftArrow]!.copyWith(status: false);
          emit(state.copyWith(rightArrow: !state.rightArrow, relaysMap: map));
          toggleRelayRover(map[Relays.leftArrow]!.relay.toString());
          //   emit(state.copyWith(
          //       rightArrow: !state.rightArrow,
          //       leftArrow: state.leftArrow.copyWith(status: false)));
          //   toggleRelayRover(state.leftArrow.relay.toString());
        } else {
          emit(state.copyWith(rightArrow: !state.rightArrow));
        }
        toggleRelayRover(state.relayRightArrow.toString());
        _playAudio(state.rightArrow, audioRightArrow);
      }
    });
    on<DashboardParkingEvent>((event, emit) {
      final map = {...state.relaysMap};
      if (!state.parking) {
        if (map[Relays.leftArrow]!.status) {
          toggleRelayRover(map[Relays.leftArrow]!.relay.toString());
          map[Relays.leftArrow]!.audio.stopAudio();
        }
        // if (state.leftArrow.status) {
        //   toggleRelayRover(state.leftArrow.relay.toString());
        //   state.leftArrow.audio.stopAudio();
        // }
        if (state.rightArrow) {
          toggleRelayRover(state.relayRightArrow.toString());
          audioRightArrow.stopAudio();
        }
        toggleRelayRover(map[Relays.leftArrow]!.relay.toString());
        // toggleRelayRover(state.leftArrow.relay.toString());
        toggleRelayRover(state.relayRightArrow.toString());
      } else {
        // toggleRelayRover(state.leftArrow.relay.toString());
        toggleRelayRover(map[Relays.leftArrow]!.relay.toString());
        toggleRelayRover(state.relayRightArrow.toString());
      }
      map[Relays.leftArrow] =
          map[Relays.leftArrow]!.copyWith(status: !state.parking);
      emit(state.copyWith(
          parking: !state.parking,
          relaysMap: map,
          // leftArrow: state.leftArrow.copyWith(status: !state.parking),
          rightArrow: !state.parking));

      _playAudio(state.parking, audioParking);
    });
    on<DashboardDoorEvent>((event, emit) {
      emit(state.copyWith(door: !state.door));
      toggleRelayRover(state.relayDoor.toString());
      _playAudio(state.door, audioDoor);
    });
    on<DashboardLightEvent>((event, emit) {
      emit(state.copyWith(light: !state.light));
      toggleRelayRover(state.relayLight.toString());
      _playAudio(state.light, audioLight);
    });
    on<DashboardClaxonEvent>((event, emit) {
      emit(state.copyWith(claxon: !state.claxon));
      toggleRelayRover(state.relayClaxon.toString());
      _playAudio(state.claxon, audioClaxon);
    });
    on<DashboardRetroEvent>((event, emit) {
      emit(state.copyWith(retro: !state.retro));
      toggleRelayRover(state.relayRetro.toString());
      _playAudio(state.retro, audioRetro);
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
    on<DashboardSetRoverStatusEvent>((event, emit) {
      emit(state.copyWith(roverStatus: event.roverStatus));
    });
    on<DashboardSetRelayEvent>((event, emit) {
      emit(state.copyWith(relay: event.relay));
    });
    on<DashboardSetRelaysMapEvent>((event, emit) {
      emit(state.copyWith(relaysMap: event.relaysMap));
    });
    syncDataRover();
    init();
  }

  void init() {
    ipBaseControler.text = state.ipRemote;
  }

  void syncDataRover() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      getStatusRover();
      getRelayRover();
    });
    getStatusRover();
    getRelayRover();
  }

  Future<void> getRelayRover() async {
    try {
      add(const DashboardIsLoadingEvent(true));
      add(const DashboardErrorMessageEvent(''));
      final relay = await roverRepository.getRelayRover(state.ipRemote);
      add(DashboardSetRelayEvent(relay));
    } catch (e) {
      add(DashboardErrorMessageEvent(e.toString()));
    } finally {
      add(const DashboardIsLoadingEvent(false));
    }
  }

  Future<void> getStatusRover() async {
    try {
      add(const DashboardIsLoadingEvent(true));
      add(const DashboardErrorMessageEvent(''));
      final roverStatus = await roverRepository.getStatusRover(state.ipRemote);
      add(DashboardSetRoverStatusEvent(roverStatus));
    } catch (e) {
      add(DashboardErrorMessageEvent(e.toString()));
    } finally {
      add(const DashboardIsLoadingEvent(false));
    }
  }

  Future<void> toggleRelayRover(String relayNumber) async {
    try {
      // TODO: RELAY NUMBER modificable por el usuario
      add(const DashboardErrorMessageEvent(''));
      final relay =
          await roverRepository.toggleRelayRover(state.ipRemote, relayNumber);
      add(DashboardSetRelayEvent(relay));
    } catch (e) {
      add(DashboardErrorMessageEvent(e.toString()));
    }
  }

  void parseRelay(RelayModel relay) {
    // TODO: IDENTIFICAR EL RELAY QUE SE ACTIVA
    final map = {...state.relaysMap};
    final relayInt = relay.relay1;
    try {
      final entry = map.entries.firstWhere(
        (entry) => entry.value.relay == relayInt,
      );
      if (relayInt == 1) {
        // map[entry.key] = entry.value.copyWith(status: true);
        add(DashboardLeftArrowEvent());
      }
    } catch (e) {
      //
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
