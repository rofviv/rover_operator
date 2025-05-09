import '../../../core/helpers/audio_helper.dart';
import '../data/models/relay_action.dart';

enum Relays {
  leftArrow,
  rightArrow,
  door,
  doorBack,
  light,
  claxon,
  retro,
}

final Map<Relays, RelayAction> relaysMap = {
  Relays.leftArrow: RelayAction(
      id: Relays.leftArrow.name,
      name: "Left Arrow",
      audio: AudioHelper("light.mp3"),
      relay: 1,
      shortcut: "CTRL + LEFT"),
  Relays.rightArrow: RelayAction(
      id: Relays.rightArrow.name,
      name: "Right Arrow",
      audio: AudioHelper("light.mp3"),
      relay: 2,
      shortcut: "CTRL + RIGHT"),
  Relays.door: RelayAction(
      id: Relays.door.name,
      name: "Door",
      audio: AudioHelper("door.mp3"),
      relay: 4,
      shortcut: "CTRL + D"),
  Relays.doorBack: RelayAction(
      id: Relays.doorBack.name,
      name: "Door Back",
      audio: AudioHelper("door.mp3"),
      relay: 8,
      shortcut: "CTRL + T"),
  Relays.light: RelayAction(
      id: Relays.light.name,
      name: "Light",
      audio: AudioHelper("beep.mp3", loop: false),
      relay: 5,
      shortcut: "CTRL + L"),
  Relays.claxon: RelayAction(
      id: Relays.claxon.name,
      name: "Claxon",
      audio: AudioHelper("beep.mp3", loop: false),
      relay: 6,
      shortcut: "CTRL + B"),
  Relays.retro: RelayAction(
      id: Relays.retro.name,
      name: "Retro",
      audio: AudioHelper("back.mp3"),
      relay: 7,
      shortcut: "CTRL + R"),
};
