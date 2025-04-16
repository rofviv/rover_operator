part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final bool activeSound;
  final bool isLoading;
  final bool isLoadingRelay;
  final String ipRemote;
  final double sizeIcon;
  final Map<Relays, RelayAction> relaysMap;
  final bool parking;
  final DateTime? lastSync;
  final String errorMessageHost;
  final String errorMessageRelay;

  final double distanceSonar1;
  final double distanceSonar2;
  final double distanceSonar3;
  final double distanceSonar4;

  final List<List<double>> pointsLidarDistanceAngle;

  final RoverStatusModel roverStatus;
  final RelayModel relay;
  final CubeStatusModel cubeStatus;
  final bool socketConnected;

  final double currentLatencyPing;
  final bool currentLatencyAlert;

  final double mapHeight;
  final double lidarHeight;

  const DashboardState({
    this.activeSound = true,
    this.isLoading = false,
    this.isLoadingRelay = false,
    this.ipRemote = '10.13.13.x',
    this.sizeIcon = 35,
    required this.relaysMap,
    this.parking = false,
    this.lastSync,
    this.errorMessageHost = "",
    this.errorMessageRelay = "",
    required this.roverStatus,
    required this.relay,
    required this.cubeStatus,
    this.socketConnected = false,
    this.distanceSonar1 = 0,
    this.distanceSonar2 = 0,
    this.distanceSonar3 = 0,
    this.distanceSonar4 = 0,
    this.currentLatencyPing = 0,
    this.currentLatencyAlert = false,
    this.mapHeight = 600,
    this.pointsLidarDistanceAngle = const [],
    this.lidarHeight = 500,
  });

  DashboardState copyWith({
    bool? activeSound,
    bool? isLoading,
    bool? isLoadingRelay,
    String? ipRemote,
    double? sizeIcon,
    Map<Relays, RelayAction>? relaysMap,
    bool? parking,
    DateTime? lastSync,
    String? errorMessageHost,
    String? errorMessageRelay,
    RoverStatusModel? roverStatus,
    RelayModel? relay,
    CubeStatusModel? cubeStatus,
    double? distanceSonar1,
    double? distanceSonar2,
    double? distanceSonar3,
    double? distanceSonar4,
    bool? socketConnected,
    double? currentLatencyPing,
    bool? currentLatencyAlert,
    double? mapHeight,
    List<List<double>>? pointsLidarDistanceAngle,
    double? lidarHeight,
  }) {
    return DashboardState(
      activeSound: activeSound ?? this.activeSound,
      isLoading: isLoading ?? this.isLoading,
      isLoadingRelay: isLoadingRelay ?? this.isLoadingRelay,
      ipRemote: ipRemote ?? this.ipRemote,
      sizeIcon: sizeIcon ?? this.sizeIcon,
      relaysMap: relaysMap ?? this.relaysMap,
      parking: parking ?? this.parking,
      lastSync: lastSync ?? this.lastSync,
      errorMessageHost: errorMessageHost ?? this.errorMessageHost,
      errorMessageRelay: errorMessageRelay ?? this.errorMessageRelay,
      roverStatus: roverStatus ?? this.roverStatus,
      relay: relay ?? this.relay,
      cubeStatus: cubeStatus ?? this.cubeStatus,
      distanceSonar1: distanceSonar1 ?? this.distanceSonar1,
      distanceSonar2: distanceSonar2 ?? this.distanceSonar2,
      distanceSonar3: distanceSonar3 ?? this.distanceSonar3,
      distanceSonar4: distanceSonar4 ?? this.distanceSonar4,
      socketConnected: socketConnected ?? this.socketConnected,
      currentLatencyPing: currentLatencyPing ?? this.currentLatencyPing,
      currentLatencyAlert: currentLatencyAlert ?? this.currentLatencyAlert,
      mapHeight: mapHeight ?? this.mapHeight,
      pointsLidarDistanceAngle:
          pointsLidarDistanceAngle ?? this.pointsLidarDistanceAngle,
      lidarHeight: lidarHeight ?? this.lidarHeight,
    );
  }

  @override
  List<Object?> get props => [
        activeSound,
        isLoading,
        isLoadingRelay,
        ipRemote,
        sizeIcon,
        relaysMap,
        parking,
        lastSync,
        errorMessageHost,
        errorMessageRelay,
        roverStatus,
        relay,
        cubeStatus,
        distanceSonar1,
        distanceSonar2,
        distanceSonar3,
        distanceSonar4,
        socketConnected,
        currentLatencyPing,
        currentLatencyAlert,
        mapHeight,
        pointsLidarDistanceAngle,
        lidarHeight,
      ];
}
