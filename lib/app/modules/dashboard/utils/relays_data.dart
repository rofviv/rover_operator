import '../../../core/helpers/audio_helper.dart';
import '../data/relay_action.dart';

enum Relays {
  leftArrow,
  rightArrow,
  // parking,
  door,
  light,
  claxon,
  retro,
}

final Map<Relays, RelayAction> relaysMap = {
  Relays.leftArrow: RelayAction(
      id: "leftArrow",
      name: "Left Arrow",
      audio: AudioHelper("light.mp3"),
      relay: 1,
      shortcut: "ALT + LEFT"),
  Relays.rightArrow: RelayAction(
      id: "rightArrow",
      name: "Right Arrow",
      audio: AudioHelper("light.mp3"),
      relay: 2,
      shortcut: "ALT + RIGHT"),
  // Relays.parking: RelayAction(
  //     id: "parking",
  //     name: "Parking",
  //     audio: audioParking,
  //     relay: 3,
  //     shortcut: "ALT + P"),
   Relays.door: RelayAction(
       id: "door",
       name: "Door",
       audio: AudioHelper("door.mp3"),
       relay: 4,
       shortcut: "ALT + D"),
  Relays.light: RelayAction(
      id: "light",
      name: "Light",
      audio: AudioHelper("beep.mp3", loop: false),
      relay: 5,
      shortcut: "ALT + L"),
  Relays.claxon: RelayAction(
      id: "claxon",
      name: "Claxon",
      audio: AudioHelper("beep.mp3", loop: false),
      relay: 6,
      shortcut: "ALT + C"),
  Relays.retro: RelayAction(
      id: "retro",
      name: "Retro",
      audio: AudioHelper("back.mp3"),
      relay: 7,
      shortcut: "ALT + R"),
};
