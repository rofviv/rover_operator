import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  late AnimatedMapController animatedMapController;
  Timer? lastDraggingTimer;

  LocationBloc()
      : super(
          const LocationState(
            center: LatLng(
              -17.798262949722087,
              -63.177556347059166,
            ),
          ),
        ) {
    on<LocationUpdateSetEvent>((event, emit) {
      emit(state.copyWith(
        center: LatLng(event.latitude, event.longitude),
        bearing: event.bearing,
        zoom: event.zoom,
      ));
      if (!state.isDragging) {
        animatedMapController.animateTo(
          dest: LatLng(event.latitude, event.longitude),
          zoom: event.zoom,
          rotation: state.rotateMap
              ? event.bearing != null
                  ? event.bearing! * -1
                  : 0
              : 0,
        );
      }
    });

    on<LocationRotateMapEvent>((event, emit) {
      animatedMapController.animateTo(
        dest: state.center,
        zoom: state.zoom,
        rotation: !state.rotateMap ? (state.bearing) * -1 : 0,
      );
      emit(state.copyWith(rotateMap: !state.rotateMap));
    });

    on<LocationDraggingEvent>((event, emit) {
      emit(state.copyWith(isDragging: event.isDragging));
      lastDraggingTimer?.cancel();
      if (event.isDragging) {
        _clearDragging();
      }
    });
  }

  void _clearDragging() {
    lastDraggingTimer = Timer(
      const Duration(seconds: 30),
      () {
        add(const LocationDraggingEvent(false));
        goToCenter();
      },
    );
  }

  void initializeMapController(TickerProvider ticketProvider) {
    animatedMapController = AnimatedMapController(
      vsync: ticketProvider,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      cancelPreviousAnimations: true,
    );
  }

  void goToCenter() {
    add(const LocationDraggingEvent(false));
    animatedMapController.animateTo(
      dest: state.center,
      zoom: state.zoom,
      rotation: state.rotateMap ? (state.bearing * -1) : 0,
    );
  }
}
