// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:google_maps/colors.dart';
import 'package:google_maps/components/button.dart';
import 'package:google_maps/components/field_box.dart';
import 'package:google_maps/components/places_search.dart';
import 'package:google_maps/components/text_input.dart';
import 'package:google_maps/controllers/contact_form_controller.dart';
import 'package:google_maps/models/contact_entity.dart';

class ContactFormView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneNumberController;
  final TextEditingController emailController;
  final ContactEntity? currentContact;
  final VoidCallback onSubmit;
  final ImageController imageController;
  final PlaceController placeController;

  const ContactFormView(
      {super.key,
      required this.formKey,
      required this.nameController,
      required this.phoneNumberController,
      required this.emailController,
      this.currentContact,
      required this.onSubmit,
      required this.imageController,
      required this.placeController});

  Widget _buildMainContent(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FieldBox(
                title: 'Nome',
                inputWidget: TextInput(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'O nome é obrigatório';
                    }
                    return null;
                  },
                  controller: nameController,
                  hintText: 'Digite o nome completo da pessoa',
                ),
              ),
              FieldBox(
                title: 'Número de telefone',
                inputWidget: TextInput(
                  size: 1,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'O número de telefone é obrigatório';
                    }
                    return null;
                  },
                  controller: phoneNumberController,
                  hintText: 'Digite o número de telefone',
                ),
              ),
              FieldBox(
                title: 'Email',
                inputWidget: TextInput(
                  size: 1,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'O email é obrigatório';
                    }
                    return null;
                  },
                  controller: emailController,
                  hintText: 'Digite seu endereço de email',
                ),
              ),
              FieldBox(
                title: 'Foto',
                inputWidget: GestureDetector(
                  onTap: () => imageController.pickImage(),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        imageController.image == null && currentContact == null
                            ? const Icon(Icons.camera_alt,
                                size: 50, color: Colors.white)
                            : (imageController.image == null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.memory(
                                        base64Decode(currentContact!.image),
                                        fit: BoxFit.cover),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(imageController.image!,
                                        fit: BoxFit.cover),
                                  )),
                  ),
                ),
              ),
              FieldBox(
                title: 'Localização',
                inputWidget: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    side: const BorderSide(
                        color: AppColors.textPrimary, width: 1),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoogleMapSearchPlacesApi(
                          onSelect: placeController.setPlace,
                        ), // O widget que você deseja empurrar
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          placeController.place?.name ??
                              currentContact?.address.toString() ??
                              "Selecionar localização",
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(
                        Icons.location_on,
                        color: AppColors.textPrimary,
                      ),
                    ],
                  ),
                ),
              ),
              // FieldBox(
              //   title: 'Endereço',
              //   inputWidget: placeController.place == null &&
              //           (currentContact == null &&
              //               currentContact?.address == null)
              //       ? Button(
              //           onPress: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => GoogleMapSearchPlacesApi(
              //                   onSelect: placeController.setPlace,
              //                 ), // O widget que você deseja empurrar
              //               ),
              //             );
              //           },
              //           title: 'Selecionar endereço',
              //           backgroundColor: Colors.greenAccent)
              //       : Text(coalesce(placeController.place?.name,
              //           currentContact?.address.toString())),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(currentContact == null ? 'Novo contato' : 'Editar contato')),
      body: Column(
        children: [
          _buildMainContent(context),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Button(
              backgroundColor: AppColors.primaryBlue,
              onPress: onSubmit,
              title: 'Enviar',
              isLoading: false,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
