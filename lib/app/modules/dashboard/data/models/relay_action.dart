import '../../../../core/helpers/audio_helper.dart';

class RelayAction {
  final String id;
  final String name;
  final String shortcut;
  final bool status;
  final int relay;
  final AudioHelper audio;

  const RelayAction({
    required this.id,
    required this.name,
    required this.shortcut,
    this.status = false,
    required this.relay,
    required this.audio,
  });

  RelayAction copyWith({
    String? id,
    String? name,
    String? shortcut,
    bool? status,
    int? relay,
    AudioHelper? audio,
  }) =>
      RelayAction(
        id: id ?? this.id,
        name: name ?? this.name,
        shortcut: shortcut ?? this.shortcut,
        status: status ?? this.status,
        relay: relay ?? this.relay,
        audio: audio ?? this.audio,
      );
}
