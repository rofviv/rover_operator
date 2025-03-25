import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

class BeepController {
  static final BeepController _instance = BeepController._internal();
  final AudioPlayer _player = AudioPlayer();
  Timer? _timer;

  factory BeepController() {
    return _instance;
  }

  BeepController._internal();

  void startBeeping(int value) {
    _timer?.cancel(); // Cancela cualquier beep anterior

    double interval = 1;
    if (value > 40) {
      interval = 0.5; // 1 segundo
    } else if (value > 25) {
      interval = 0.3; // 0.5 segundos
    } else if (value > 0) {
      interval = 0.1; // 0.2 segundos
    } else {
      stopBeeping();
      _timer = null;
      return;
    }

    _timer =
        Timer.periodic(Duration(milliseconds: (interval * 1000).toInt()), (_) {
      _playBeep();
    });
  }

  void stopBeeping() {
    _timer?.cancel();
  }

  Future<void> _playBeep() async {
    await _player.play(AssetSource(
        'sounds/beep.mp3')); // Asegúrate de tener un archivo beep.mp3 en assets
  }
}
