// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps/models/contact_entity.dart';

class PlaceEntity {
  final String name;
  final Coordinates address;
  
  const PlaceEntity({
    required this.name,
    required this.address,
  });
}
