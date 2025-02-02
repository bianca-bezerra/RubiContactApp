import 'dart:convert';
import 'dart:io';

import 'package:google_maps/models/contact_entity.dart';
import 'package:google_maps/models/contact_repository.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class CreateContactController extends ChangeNotifier {
  File? _image;

  File? get image => _image;

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

  Future<void> submit(String name, String phoneNumber, String email) async {
     
    if(_image == null) return;
    
    isSubmting = true;
    notifyListeners();


    try {
      final payload = ContactEntity(id: -1, name: name, phoneNumber: phoneNumber, email: email, image: base64Encode(_image!.readAsBytesSync()), address: Coordinates(latitude: -5.059541445112961, longitude:  -42.78714407346994));
      await _contactRepository.create(payload);

      isSubmting = false;
      isSuccess = true;
      _image = null;
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