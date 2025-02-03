import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps/models/contact_entity.dart';
import 'package:google_maps/models/place_entity.dart';
import 'package:google_maps/routing/routes.dart';
import 'package:google_maps/utils/scream.dart';
import 'package:google_maps/views/contact_form.dart';
import 'package:provider/provider.dart';

import 'package:google_maps/models/contact_repository.dart';

import 'package:path_provider/path_provider.dart'; // Para obter o diretório do dispositivo

import 'package:image_picker/image_picker.dart';

class ImageController extends ChangeNotifier {
  File? _image;

  File? get image => _image;

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

  void setImage(String base64Image) async {
    _image = await base64ToFile(base64Image, "tmp_image");
    notifyListeners();
  }

  void clear() {
    _image?.delete();
    _image = null;
    notifyListeners();
  }

  Future<File> base64ToFile(String base64String, String fileName) async {
    // Decodificando a string Base64 para bytes
    final bytes = base64Decode(base64String);

    // Obtendo o diretório temporário para salvar o arquivo
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/$fileName';

    // Criando um arquivo a partir dos bytes decodificados
    final file = File(path);

    // Escrevendo os bytes no arquivo
    await file.writeAsBytes(bytes);

    return file;
  }
}

class PlaceController extends ChangeNotifier {
  PlaceEntity? _place;

  PlaceEntity? get place => _place;

  void setPlace(PlaceEntity place) {
    _place = place;
    notifyListeners();
  }

  void clear() {
    _place = null;
    notifyListeners();
  }
}

class ContactFormController extends StatefulWidget {
  final ContactEntity? currentContact;

  const ContactFormController({super.key, this.currentContact});

  @override
  State<ContactFormController> createState() => _ContactFormControllerState();
}

class _ContactFormControllerState extends State<ContactFormController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;
  late PlaceController _placeController;
  late ImageController _imageController;

  @override
  void initState() {
    _nameController =
        TextEditingController(text: widget.currentContact?.name ?? "");
    _phoneNumberController =
        TextEditingController(text: widget.currentContact?.phoneNumber ?? "");
    _emailController =
        TextEditingController(text: widget.currentContact?.email ?? "");
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void submit() async {
    final isCreating = widget.currentContact == null;

    if (isCreating &&
        (_imageController.image == null || _placeController._place == null)) {
      return;
    }

    final contactRepository = ContactRepository();

    try {
      if (widget.currentContact == null) {
        final payload = ContactEntity(
            id: -1,
            name: _nameController.text,
            phoneNumber: _phoneNumberController.text,
            email: _emailController.text,
            image: base64Encode(_imageController.image!.readAsBytesSync()),
            address: Coordinates(
                latitude: _placeController.place!.address.latitude,
                longitude: _placeController.place!.address.longitude));
        await contactRepository.create(payload);
      } else {
        final payload = ContactEntity(
            id: widget.currentContact!.id,
            name: _nameController.text.isEmpty
                ? widget.currentContact!.name
                : _nameController.text,
            phoneNumber: _phoneNumberController.text.isEmpty
                ? widget.currentContact!.phoneNumber
                : _phoneNumberController.text,
            email: _emailController.text.isEmpty
                ? widget.currentContact!.email
                : _emailController.text,
            image: _imageController._image != null
                ? base64Encode(_imageController.image!.readAsBytesSync())
                : widget.currentContact!.image,
            address: _placeController.place != null
                ? Coordinates(
                    latitude: _placeController.place!.address.latitude,
                    longitude: _placeController.place!.address.longitude)
                : widget.currentContact!.address);
        await contactRepository.updateContact(payload);
      }

      _placeController.clear();
      _imageController.clear();

      if (mounted) {
        GoRouter.of(context).go(Routes.contactsList);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    _imageController = Provider.of<ImageController>(context);
    _placeController = Provider.of<PlaceController>(context);
    return ContactFormView(
      formKey: _formKey,
      nameController: _nameController,
      phoneNumberController: _phoneNumberController,
      emailController: _emailController,
      currentContact: widget.currentContact,
      onSubmit: submit,
      imageController: _imageController,
      placeController: _placeController,
    );
  }
}
