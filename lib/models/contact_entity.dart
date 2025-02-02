// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/widgets.dart';

class ContactEntity {
  int id;
  String name;
  String phoneNumber;
  String email;
  String image;
  Coordinates address;
  ContactEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.image,
    required this.address,
  });

  ContactEntity copyWith({
    int? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? image,
    Coordinates? address,
  }) {
    return ContactEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      image: image ?? this.image,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phoneNumber,
      'email': email,
      'image': image,
      'latLng': address.toString(),
    };
  }

  factory ContactEntity.fromMap(Map<String, dynamic> map) {
    return ContactEntity(
      id: map['id'] as int,
      name: map['name'] as String,
      phoneNumber: map['phone'] as String,
      email: map['email'] as String,
      image:map['image'] as String,
      address: Coordinates.fromString(map['latLng'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactEntity.fromJson(String source) =>
      ContactEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ContactEntity(id: $id, name: $name, phoneNumber: $phoneNumber, email: $email, image: $image, address: $address)';
  }

  @override
  bool operator ==(covariant ContactEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.image == image &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        image.hashCode ^
        address.hashCode;
  }
}

class Coordinates {
  double latitude;
  double longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  Coordinates copyWith({
    double? latitude,
    double? longitude,
  }) {
    return Coordinates(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Coordinates.fromMap(Map<String, dynamic> map) {
    return Coordinates(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  factory Coordinates.fromString(String coordinates) {
    final array = coordinates.split(", ");
    return Coordinates(
      latitude: double.parse(array[0]),
      longitude:double.parse(array[1]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Coordinates.fromJson(String source) =>
      Coordinates.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      '$latitude, $longitude';

  @override
  bool operator ==(covariant Coordinates other) {
    if (identical(this, other)) return true;

    return other.latitude == latitude && other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
