import 'package:audioplayers/audioplayers.dart';

class AudioHelper {
  late AudioPlayer _audioPlayer;
  final String fileName;

  AudioHelper(this.fileName, {bool loop = true}) {
    _audioPlayer = AudioPlayer();
    if (loop) {
      _audioPlayer.setReleaseMode(ReleaseMode.loop);
    }
  }

  Future<void> playAudio() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource("sounds/$fileName"));
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }
}
