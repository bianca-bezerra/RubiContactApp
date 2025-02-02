import 'dart:convert';
import 'dart:io';

import 'package:google_maps/models/contact_entity.dart';
import 'package:google_maps/models/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/models/place_entity.dart';

import 'package:image_picker/image_picker.dart';

class CreateContactController extends ChangeNotifier {
  File? _image;
  PlaceEntity? _place;

  File? get image => _image;
  PlaceEntity? get place => _place;

  final _contactRepository = ContactRepository();
  bool isSubmting = false;
  bool? isSuccess;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners(); // Atualiza a UI quando uma imagem for selecionada
    }
  }

  void setPlace(PlaceEntity place) {
    _place = place;
    notifyListeners();
  }

  void clearInputs() {
    _image = null;
    _place = null;
  }

  Future<void> submit(String name, String phoneNumber, String email) async {
    if (image == null || place == null) return;

    isSubmting = true;
    notifyListeners();

    try {
      final payload = ContactEntity(
          id: -1,
          name: name,
          phoneNumber: phoneNumber,
          email: email,
          image: base64Encode(image!.readAsBytesSync()),
          address: Coordinates(
              latitude: place!.address.latitude,
              longitude: place!.address.longitude));
      await _contactRepository.create(payload);

      isSubmting = false;
      isSuccess = true;
      clearInputs();
      notifyListeners();
    } catch (e) {
      isSuccess = false;
      notifyListeners();
    } finally {
      isSubmting = false;
      notifyListeners();
    }
  }
}
