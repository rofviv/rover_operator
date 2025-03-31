part of 'location_bloc.dart';

class LocationState extends Equatable {
  final LatLng center;
  final double zoom;
  final double bearing;
  final bool rotateMap;
  final bool isDragging;

  const LocationState({
    required this.center,
    this.zoom = 17,
    this.bearing = 0,
    this.rotateMap = true,
    this.isDragging = false,
  });

  LocationState copyWith({
    LatLng? center,
    double? zoom,
    double? bearing,
    bool? rotateMap,
    bool? isDragging,
  }) =>
      LocationState(
        center: center ?? this.center,
        zoom: zoom ?? this.zoom,
        bearing: bearing ?? this.bearing,
        rotateMap: rotateMap ?? this.rotateMap,
        isDragging: isDragging ?? this.isDragging,
      );

  @override
  List<Object?> get props => [
        center,
        zoom,
        bearing,
        rotateMap,
        isDragging,
      ];
}
