part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final bool isLoading;
  final String ipRemote;
  final double sizeIcon;
  final bool leftArrow;
  final bool rightArrow;
  final bool parking;
  final bool door;
  final bool light;
  final bool claxon;
  final bool retro;
  final DateTime? lastSync;
  final String errorMessage;

  const DashboardState({
    this.isLoading = false,
    this.ipRemote = '10.13.13.x',
    this.sizeIcon = 35,
    this.leftArrow = false,
    this.rightArrow = false,
    this.parking = false,
    this.door = false,
    this.light = false,
    this.claxon = false,
    this.retro = false,
    this.lastSync,
    this.errorMessage = "",
  });

  DashboardState copyWith({
    bool? isLoading,
    String? ipRemote,
    double? sizeIcon,
    bool? leftArrow,
    bool? rightArrow,
    bool? parking,
    bool? door,
    bool? light,
    bool? claxon,
    bool? retro,
    DateTime? lastSync,
    String? errorMessage,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      ipRemote: ipRemote ?? this.ipRemote,
      sizeIcon: sizeIcon ?? this.sizeIcon,
      leftArrow: leftArrow ?? this.leftArrow,
      rightArrow: rightArrow ?? this.rightArrow,
      parking: parking ?? this.parking,
      door: door ?? this.door,
      light: light ?? this.light,
      claxon: claxon ?? this.claxon,
      retro: retro ?? this.retro,
      lastSync: lastSync ?? this.lastSync,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        ipRemote,
        sizeIcon,
        leftArrow,
        rightArrow,
        parking,
        door,
        light,
        claxon,
        retro,
        lastSync,
        errorMessage,
      ];
}
