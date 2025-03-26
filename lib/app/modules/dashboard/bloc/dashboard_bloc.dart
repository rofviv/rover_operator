import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rover_operator/app/modules/dashboard/utils/keys.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../core/helpers/audio_helper.dart';
import '../../../core/preferences_repository.dart';
import '../data/relay_model.dart';
import '../data/relay_action.dart';
import '../data/rover_repository.dart';
import '../data/rover_status_mode.dart';
import '../utils/audio_key.dart';
import '../utils/beep_controller.dart';
import '../utils/relays_data.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final RoverRepository roverRepository;
  final PreferencesRepository preferencesRepository;
  Timer? _timer;

  DashboardBloc(this.roverRepository, this.preferencesRepository)
      : super(
          DashboardState(
            relaysMap: relaysMap,
            roverStatus: RoverStatusModel(),
            relay: RelayModel(),
          ),
        ) {
    on<DashboardSizeIconEvent>((event, emit) async {
      await preferencesRepository.setSizeIcon(event.sizeIcon.toString());
      emit(state.copyWith(sizeIcon: event.sizeIcon));
    });
    on<DashboardLeftArrowEvent>((event, emit) {
      if (!state.parking) {
        final map = {...state.relaysMap};
        map[Relays.leftArrow] = map[Relays.leftArrow]!
            .copyWith(status: !map[Relays.leftArrow]!.status);
        if (map[Relays.rightArrow]!.status) {
          map[Relays.rightArrow] =
              map[Relays.rightArrow]!.copyWith(status: false);
          map[Relays.rightArrow]!.audio.stopAudio();
          toggleRelayRover(map[Relays.rightArrow]!.relay.toString());
        }
        emit(state.copyWith(relaysMap: map));
        toggleRelayRover(map[Relays.leftArrow]!.relay.toString());
        _playAudio(map[Relays.leftArrow]!.status, map[Relays.leftArrow]!.audio);
      }
    });
    on<DashboardRightArrowEvent>((event, emit) {
      if (!state.parking) {
        final map = {...state.relaysMap};
        map[Relays.rightArrow] = map[Relays.rightArrow]!
            .copyWith(status: !map[Relays.rightArrow]!.status);
        if (map[Relays.leftArrow]!.status) {
          map[Relays.leftArrow]!.audio.stopAudio();
          map[Relays.leftArrow] =
              map[Relays.leftArrow]!.copyWith(status: false);
          toggleRelayRover(map[Relays.leftArrow]!.relay.toString());
        }
        emit(state.copyWith(relaysMap: map));
        toggleRelayRover(map[Relays.rightArrow]!.relay.toString());
        _playAudio(
            map[Relays.rightArrow]!.status, map[Relays.rightArrow]!.audio);
      }
    });
    on<DashboardParkingEvent>((event, emit) {
      final map = {...state.relaysMap};
      if (!state.parking) {
        if (map[Relays.leftArrow]!.status) {
          toggleRelayRover(map[Relays.leftArrow]!.relay.toString());
          map[Relays.leftArrow]!.audio.stopAudio();
        }
        if (map[Relays.rightArrow]!.status) {
          toggleRelayRover(map[Relays.rightArrow]!.relay.toString());
          map[Relays.rightArrow]!.audio.stopAudio();
        }
        toggleRelayRover(map[Relays.leftArrow]!.relay.toString());
        toggleRelayRover(map[Relays.rightArrow]!.relay.toString());
      } else {
        toggleRelayRover(map[Relays.leftArrow]!.relay.toString());
        toggleRelayRover(map[Relays.rightArrow]!.relay.toString());
      }
      map[Relays.leftArrow] =
          map[Relays.leftArrow]!.copyWith(status: !state.parking);
      map[Relays.rightArrow] =
          map[Relays.rightArrow]!.copyWith(status: !state.parking);
      emit(
        state.copyWith(
          parking: !state.parking,
          relaysMap: map,
        ),
      );

      _playAudio(state.parking, audioParking);
    });
    on<DashboardDoorEvent>((event, emit) {
      final map = {...state.relaysMap};
      map[Relays.door] =
          map[Relays.door]!.copyWith(status: !map[Relays.door]!.status);
      emit(state.copyWith(relaysMap: map));
      toggleRelayRover(map[Relays.door]!.relay.toString());
      _playAudio(map[Relays.door]!.status, map[Relays.door]!.audio);
    });
    on<DashboardLightEvent>((event, emit) {
      final map = {...state.relaysMap};
      map[Relays.light] =
          map[Relays.light]!.copyWith(status: !map[Relays.light]!.status);
      emit(state.copyWith(relaysMap: map));
      toggleRelayRover(map[Relays.light]!.relay.toString());
      _playAudio(map[Relays.light]!.status, map[Relays.light]!.audio);
    });
    on<DashboardClaxonEvent>((event, emit) {
      final map = {...state.relaysMap};
      map[Relays.claxon] =
          map[Relays.claxon]!.copyWith(status: !map[Relays.claxon]!.status);
      emit(state.copyWith(relaysMap: map));
      toggleRelayRover(map[Relays.claxon]!.relay.toString());
      _playAudio(map[Relays.claxon]!.status, map[Relays.claxon]!.audio);
    });
    on<DashboardRetroEvent>((event, emit) {
      final map = {...state.relaysMap};
      map[Relays.retro] =
          map[Relays.retro]!.copyWith(status: !map[Relays.retro]!.status);
      emit(state.copyWith(relaysMap: map));
      toggleRelayRover(map[Relays.retro]!.relay.toString());
      _playAudio(map[Relays.retro]!.status, map[Relays.retro]!.audio);
    });
    on<DashboardIpRemoteEvent>((event, emit) async {
      await preferencesRepository.setIpRemote(event.ipRemote);
      emit(state.copyWith(ipRemote: event.ipRemote));
      await Future.delayed(const Duration(milliseconds: 1000));
      syncDataRover();
    });
    on<DashboardErrorMessageHostEvent>((event, emit) {
      emit(state.copyWith(errorMessageHost: event.errorMessage));
    });
    on<DashboardErrorMessageRelayEvent>((event, emit) {
      emit(state.copyWith(errorMessageRelay: event.errorMessage));
    });
    on<DashboardIsLoadingEvent>((event, emit) {
      emit(state.copyWith(isLoading: event.isLoading));
    });
    on<DashboardIsLoadingRelayEvent>((event, emit) {
      emit(state.copyWith(isLoadingRelay: event.isLoadingRelay));
    });
    on<DashboardSetRoverStatusEvent>((event, emit) {
      emit(state.copyWith(roverStatus: event.roverStatus));
    });
    on<DashboardSetRelayEvent>((event, emit) {
      emit(state.copyWith(relay: event.relay));
    });
    on<DashboardSetRelaysMapEvent>((event, emit) {
      if (event.relaysMap[Relays.leftArrow]!.status !=
              state.relaysMap[Relays.leftArrow]!.status ||
          event.relaysMap[Relays.rightArrow]!.status !=
              state.relaysMap[Relays.rightArrow]!.status) {
        if (event.relaysMap[Relays.leftArrow]!.status &&
            event.relaysMap[Relays.rightArrow]!.status &&
            !state.parking) {
          event.relaysMap[Relays.leftArrow]!.audio.stopAudio();
          event.relaysMap[Relays.rightArrow]!.audio.stopAudio();
          _playAudio(true, audioParking);
          emit(state.copyWith(parking: true));
        } else if (!event.relaysMap[Relays.leftArrow]!.status &&
            !event.relaysMap[Relays.rightArrow]!.status &&
            state.parking) {
          _playAudio(false, audioParking);
          emit(state.copyWith(parking: false));
        }
      }
      emit(state.copyWith(relaysMap: event.relaysMap));
    });
    on<DashboardSetRelaysEvent>((event, emit) {
      emit(state.copyWith(relaysMap: event.relaysMap));
    });
    on<DashboardSetDistanceSonar1Event>((event, emit) {
      emit(state.copyWith(distanceSonar1: event.distanceSonar1));
    });
    on<DashboardSetDistanceSonar2Event>((event, emit) {
      emit(state.copyWith(distanceSonar2: event.distanceSonar2));
    });
    on<DashboardSetDistanceSonar3Event>((event, emit) {
      emit(state.copyWith(distanceSonar3: event.distanceSonar3));
    });
    on<DashboardSetDistanceSonar4Event>((event, emit) {
      emit(state.copyWith(distanceSonar4: event.distanceSonar4));
    });
    on<DashboardSetActiveSoundEvent>((event, emit) {
      emit(state.copyWith(activeSound: event.activeSound));
    });
    on<DashboardSetSocketConnectedEvent>((event, emit) {
      emit(state.copyWith(socketConnected: event.socketConnected));
    });
    init();
    socket();
  }

  void init() async {
    final ipRemote = await preferencesRepository.ipRemote;
    final sizeIcon = await preferencesRepository.sizeIcon;
    if (sizeIcon != null) {
      add(DashboardSizeIconEvent(double.parse(sizeIcon)));
    }
    if (ipRemote != null) {
      ipRemoteControler.text = ipRemote;
      add(DashboardIpRemoteEvent(ipRemote));
    } else {
      syncDataRover();
    }
    _readRelayNumber();
  }

  void _readRelayNumber() async {
    final map = {...state.relaysMap};
    final leftArrow =
        await preferencesRepository.getRelay(Relays.leftArrow.toString());
    if (leftArrow != null) {
      map[Relays.leftArrow] = map[Relays.leftArrow]!.copyWith(relay: leftArrow);
    }
    final rightArrow =
        await preferencesRepository.getRelay(Relays.rightArrow.toString());
    if (rightArrow != null) {
      map[Relays.rightArrow] =
          map[Relays.rightArrow]!.copyWith(relay: rightArrow);
    }
    final door = await preferencesRepository.getRelay(Relays.door.toString());
    if (door != null) {
      map[Relays.door] = map[Relays.door]!.copyWith(relay: door);
    }
    final light = await preferencesRepository.getRelay(Relays.light.toString());
    if (light != null) {
      map[Relays.light] = map[Relays.light]!.copyWith(relay: light);
    }
    final claxon =
        await preferencesRepository.getRelay(Relays.claxon.toString());
    if (claxon != null) {
      map[Relays.claxon] = map[Relays.claxon]!.copyWith(relay: claxon);
    }
    final retro = await preferencesRepository.getRelay(Relays.retro.toString());
    if (retro != null) {
      map[Relays.retro] = map[Relays.retro]!.copyWith(relay: retro);
    }
    add(DashboardSetRelaysEvent(map));
  }

  void setRelays(Relays key, int value) async {
    await preferencesRepository.setRelays(key.toString(), value);
    final map = {...state.relaysMap};
    map[key] = map[key]!.copyWith(relay: value);
    add(DashboardSetRelaysEvent(map));
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
      add(const DashboardIsLoadingRelayEvent(true));
      add(const DashboardErrorMessageRelayEvent(''));
      final relay = await roverRepository.getRelayRover(state.ipRemote);
      add(DashboardSetRelayEvent(relay));
      await parseRelay(relay);
    } catch (e) {
      add(DashboardErrorMessageRelayEvent(e.toString()));
    } finally {
      add(const DashboardIsLoadingRelayEvent(false));
    }
  }

  Future<void> getStatusRover() async {
    try {
      add(const DashboardIsLoadingEvent(true));
      add(const DashboardErrorMessageHostEvent(''));
      final roverStatus = await roverRepository.getStatusRover(state.ipRemote);
      add(DashboardSetRoverStatusEvent(roverStatus));
    } catch (e) {
      add(DashboardErrorMessageHostEvent(e.toString()));
    } finally {
      add(const DashboardIsLoadingEvent(false));
    }
  }

  Future<void> toggleRelayRover(String relayNumber) async {
    try {
      add(const DashboardErrorMessageRelayEvent(''));
      final relay =
          await roverRepository.toggleRelayRover(state.ipRemote, relayNumber);
      add(DashboardSetRelayEvent(relay));
    } catch (e) {
      add(DashboardErrorMessageRelayEvent(e.toString()));
    }
  }

  Future<void> parseRelay(RelayModel relay) async {
    Map<Relays, RelayAction> map = {...state.relaysMap};
    map = await _readListRelays(1, relay.relay1 ?? 0, map) ?? map;
    map = await _readListRelays(2, relay.relay2 ?? 0, map) ?? map;
    map = await _readListRelays(3, relay.relay3 ?? 0, map) ?? map;
    map = await _readListRelays(4, relay.relay4 ?? 0, map) ?? map;
    map = await _readListRelays(5, relay.relay5 ?? 0, map) ?? map;
    map = await _readListRelays(6, relay.relay6 ?? 0, map) ?? map;
    map = await _readListRelays(7, relay.relay7 ?? 0, map) ?? map;
    map = await _readListRelays(8, relay.relay8 ?? 0, map) ?? map;
    add(DashboardSetRelaysMapEvent(map));
  }

  Future<Map<Relays, RelayAction>?> _readListRelays(
      int relayNumber, int relayStatus, Map<Relays, RelayAction> map) async {
    try {
      final entry = map.entries.firstWhere(
        (entry) => entry.value.relay == relayNumber,
      );
      if (relayStatus == 1 && !entry.value.status) {
        map[entry.key] = map[entry.key]!.copyWith(status: true);
        await entry.value.audio.playAudio();
      } else if (relayStatus == 0 && entry.value.status) {
        map[entry.key] = map[entry.key]!.copyWith(status: false);
        await entry.value.audio.stopAudio();
      }
      return map;
    } catch (e) {
      return null;
    }
  }

  void _playAudio(bool isActive, AudioHelper audioHelper) {
    if (state.activeSound) {
      if (isActive) {
        audioHelper.playAudio();
      } else {
        audioHelper.stopAudio();
      }
    }
  }

  void socket() {
    IO.Socket socket = IO.io(
        'http://localhost:5000',
        IO.OptionBuilder().setTransports(['websocket']) // Usar solo WebSocket
            .setExtraHeaders({'Origin': '*'}) // Evitar bloqueos por CORS
            .build());
    socket.onConnect((_) {
      add(const DashboardSetSocketConnectedEvent(true));
    });
    socket.on('sensor_data', (data) {
      if (data["sensor"].contains("sonar")) {
        if (state.activeSound) {
          BeepController()
              .startBeeping(data["distance"].toInt(), data["sensor"]);
        }
        if (data["sensor"] == "sonar-1") {
          add(DashboardSetDistanceSonar1Event(data["distance"].toDouble()));
        } else if (data["sensor"] == "sonar-2") {
          add(DashboardSetDistanceSonar2Event(data["distance"].toDouble()));
        } else if (data["sensor"] == "sonar-3") {
          add(DashboardSetDistanceSonar3Event(data["distance"].toDouble()));
        } else if (data["sensor"] == "sonar-4") {
          add(DashboardSetDistanceSonar4Event(data["distance"].toDouble()));
        }
      }
      if (data["sensor"] == "lidar") {
        // TODO: Implementar el lidar
      }
    });
    socket.onDisconnect((_) => add(const DashboardSetSocketConnectedEvent(false)));
    socket.onError((error) => add(const DashboardSetSocketConnectedEvent(false)));
  }
}
