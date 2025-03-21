part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final bool isLoading;
  final bool isLoadingRelay;
  final String ipRemote;
  final double sizeIcon;
  final Map<Relays, RelayAction> relaysMap;
  final bool parking;
  final DateTime? lastSync;
  final String errorMessageHost;
  final String errorMessageRelay;

  final RoverStatusModel roverStatus;
  final RelayModel relay;

  const DashboardState({
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
  });

  DashboardState copyWith({
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
  }) {
    return DashboardState(
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
    );
  }

  @override
  List<Object?> get props => [
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
      ];
}
