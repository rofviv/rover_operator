import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  
  LocationBloc()
      : super(
          const LocationState(
            center: LatLng(
              -17.798262949722087,
              -63.177556347059166,
            ),
            zoom: 16,
          ),
        ) {
    on<LocationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
