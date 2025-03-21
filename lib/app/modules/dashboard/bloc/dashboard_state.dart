part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final bool isLoading;
  final String ipRemote;
  final double sizeIcon;
  final Map<Relays, RelayAction> relaysMap;
  // final RelayAction leftArrow;
  // final bool leftArrow;
  // final int relayLeftArrow;
  final bool rightArrow;
  final int relayRightArrow;
  final bool parking;
  final bool door;
  final int relayDoor;
  final bool light;
  final int relayLight;
  final bool claxon;
  final int relayClaxon;
  final bool retro;
  final int relayRetro;
  final DateTime? lastSync;
  final String errorMessage;

  final RoverStatusModel roverStatus;
  final RelayModel relay;

  const DashboardState({
    this.isLoading = false,
    this.ipRemote = '10.13.13.x',
    this.sizeIcon = 35,
    required this.relaysMap,
    // this.leftArrow = false,
    // this.relayLeftArrow = 1,
    // required this.leftArrow,
    this.rightArrow = false,
    this.relayRightArrow = 2,
    this.parking = false,
    this.door = false,
    this.relayDoor = 3,
    this.light = false,
    this.relayLight = 4,
    this.claxon = false,
    this.relayClaxon = 5,
    this.retro = false,
    this.relayRetro = 6,
    this.lastSync,
    this.errorMessage = "",
    required this.roverStatus,
    required this.relay,
  });

  DashboardState copyWith({
    bool? isLoading,
    String? ipRemote,
    double? sizeIcon,
    Map<Relays, RelayAction>? relaysMap,
    // RelayAction? leftArrow,
    // bool? leftArrow,
    // int? relayLeftArrow,
    bool? rightArrow,
    int? relayRightArrow,
    bool? parking,
    bool? door,
    int? relayDoor,
    bool? light,
    int? relayLight,
    bool? claxon,
    int? relayClaxon,
    bool? retro,
    int? relayRetro,
    DateTime? lastSync,
    String? errorMessage,
    RoverStatusModel? roverStatus,
    RelayModel? relay,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      ipRemote: ipRemote ?? this.ipRemote,
      sizeIcon: sizeIcon ?? this.sizeIcon,
      relaysMap: relaysMap ?? this.relaysMap,
      // leftArrow: leftArrow ?? this.leftArrow,
      // leftArrow: leftArrow ?? this.leftArrow,
      // relayLeftArrow: relayLeftArrow ?? this.relayLeftArrow,
      rightArrow: rightArrow ?? this.rightArrow,
      relayRightArrow: relayRightArrow ?? this.relayRightArrow,
      parking: parking ?? this.parking,
      door: door ?? this.door,
      relayDoor: relayDoor ?? this.relayDoor,
      light: light ?? this.light,
      relayLight: relayLight ?? this.relayLight,
      claxon: claxon ?? this.claxon,
      relayClaxon: relayClaxon ?? this.relayClaxon,
      retro: retro ?? this.retro,
      relayRetro: relayRetro ?? this.relayRetro,
      lastSync: lastSync ?? this.lastSync,
      errorMessage: errorMessage ?? this.errorMessage,
      roverStatus: roverStatus ?? this.roverStatus,
      relay: relay ?? this.relay,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        ipRemote,
        sizeIcon,
        relaysMap,
        // leftArrow,
        // relayLeftArrow,
        rightArrow,
        relayRightArrow,
        parking,
        door,
        relayDoor,
        light,
        relayLight,
        claxon,
        relayClaxon,
        retro,
        lastSync,
        errorMessage,
        roverStatus,
        relay,
      ];
}
