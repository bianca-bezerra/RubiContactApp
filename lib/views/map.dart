import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapInterface extends StatelessWidget {
  final Completer<GoogleMapController> mapController;
  final CameraPosition initialPosition;
  final Set<Marker> markers;

  const MapInterface(
      {super.key,
      required this.mapController,
      required this.initialPosition,
      required this.markers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,
        mapType: MapType.normal,
        markers: markers,
        initialCameraPosition: initialPosition,
        onMapCreated: (GoogleMapController controller) {
          mapController.complete(controller);
        },
      ),
    );
  }
}
