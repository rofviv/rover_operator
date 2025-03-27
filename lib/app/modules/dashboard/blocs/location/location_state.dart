part of 'location_bloc.dart';

class LocationState extends Equatable {
  final LatLng center;
  final double zoom;
  const LocationState({
    required this.center,
    required this.zoom,
  });

  LocationState copyWith({
    LatLng? center,
    double? zoom,
  }) =>
      LocationState(
        center: center ?? this.center,
        zoom: zoom ?? this.zoom,
      );

  @override
  List<Object> get props => [center, zoom];
}
