import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

class BeepController {
  static final BeepController _instance = BeepController._internal();
  final AudioPlayer _player = AudioPlayer();
  Timer? _timer;

  String sensor = "";
  double distance = 0;

  factory BeepController() {
    return _instance;
  }

  BeepController._internal();

  void startBeeping(int value, String sensor) {
    if (value != 0) {
      if (distance == 0 || value < distance) {
        distance = value.toDouble();
        this.sensor = sensor;
      }
      // else {
      //   if (this.sensor == sensor) {
      //     distance = 0;
      //     this.sensor = "";
      //   }
      // }
    } else {
      distance = 0;
      this.sensor = "";
    }
    _timer?.cancel(); // Cancela cualquier beep anterior

    double interval = 1;
    if (distance > 60) {
      interval = 1; // 1 segundo
    } else if (distance > 40) {
      interval = 0.5; // 0.5 segundos
    } else if (distance > 30) {
      interval = 0.3;
    } else if (distance > 0) {
      interval = 0.1;
    } else {
      stopBeeping();
      _timer = null;
      return;
    }
    _playBeep();

    _timer =
        Timer.periodic(Duration(milliseconds: (interval * 1000).toInt()), (_) {
      _playBeep();
    });
  }

  void stopBeeping() {
    _timer?.cancel();
  }

  Future<void> _playBeep() async {
    if (_player.source == null) {
      await _player.setSource(AssetSource('sounds/beep.mp3'));
    }
    _player.resume();
  }
}
