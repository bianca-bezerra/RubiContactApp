import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  final Completer<GoogleMapController> mapController;
  final CameraPosition initialPosition;
  final Set<Marker> markers;
  final bool isLoading;

  const MapView(
      {super.key,
      required this.mapController,
      required this.initialPosition,
      required this.markers,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de contatos'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : markers.isEmpty
              ? const Center(child: Text("Nenhum contato adicionado!"))
              : GoogleMap(
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
