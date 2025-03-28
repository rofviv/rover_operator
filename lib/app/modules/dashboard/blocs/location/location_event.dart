part of 'location_bloc.dart';

class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationUpdateSetEvent extends LocationEvent {
  final double latitude;
  final double longitude;
  final double? zoom;
  final double? bearing;

  const LocationUpdateSetEvent({
    required this.latitude,
    required this.longitude,
    this.zoom,
    required this.bearing,
  });
}

class LocationRotateMapEvent extends LocationEvent {}

class LocationDraggingEvent extends LocationEvent {
  final bool isDragging;

  const LocationDraggingEvent(this.isDragging);
}
