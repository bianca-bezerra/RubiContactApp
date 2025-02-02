import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps/models/contact_entity.dart';
import 'package:google_maps/models/contact_repository.dart';
import 'package:google_maps/views/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPageController extends StatefulWidget {
  const MapPageController({super.key});

  @override
  State<MapPageController> createState() => MapPageControllerState();
}

class MapPageControllerState extends State<MapPageController> {
  late ContactRepository _contactRepository;

  List<ContactEntity> contacts = [];
  List<ContactEntity> fetchedContacts = [];
  bool isLoading = false;

  Set<Marker> _markers = {};
  @override
  void initState() {
    super.initState();
    _contactRepository = ContactRepository();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await _contactRepository.getContacts();
      final markers = await _createMarkers(result);
      setState(() {
        contacts = result;
        fetchedContacts = result;
        _markers = markers;
      });
    } catch (e) {
      setState(() {
        contacts = [];
        _markers = {};
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Set<Marker> _createMarkers(List<ContactEntity> contacts) {
  //   return contacts.map((contact) {
  //     return Marker(
  //       markerId: MarkerId(contact.id.toString()),
  //       position: LatLng(contact.address.latitude, contact.address.longitude),

  //     );
  //   }).toSet();
  // }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _initalPosition = CameraPosition(
    target: LatLng(-5.094520, -42.800107),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return MapView(
      mapController: _controller,
      initialPosition: _initalPosition,
      markers: _markers,
      isLoading: isLoading,
    );
  }

  Future<Set<Marker>> _createMarkers(List<ContactEntity> contacts) async {
    Set<Marker> markers = {};

    for (ContactEntity contact in contacts) {
      markers.add(await _createMarker(contact));
    }

    return markers;
  }

  Future<Marker> _createMarker(ContactEntity contact) async {
    late BitmapDescriptor icon;

    // final http.Response response = await http.get(Uri.parse(contact.image));
    icon = BitmapDescriptor.bytes(base64Decode(contact.image),
        height: 100, width: 100);

    Marker marker = Marker(
      infoWindow: InfoWindow(title: contact.name),
      markerId: MarkerId(contact.id.toString()),
      position: LatLng((contact.address.latitude), contact.address.longitude),
      icon: icon,
      // onTap: () {
      //   Get.dialog(Dialog(
      //     child: LocationDescriptionPage(location: location),
      //   ));}
    );
    return marker;
  }
}
