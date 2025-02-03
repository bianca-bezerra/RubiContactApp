// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_maps/colors.dart';
// import 'package:google_maps/components/button.dart';
// import 'package:google_maps/components/field_box.dart';
// import 'package:google_maps/components/places_search.dart';
// import 'package:google_maps/components/text_input.dart';
// import 'package:google_maps/controllers/contact_form_controller.dart';
// import 'package:google_maps/models/contact_entity.dart';
// import 'package:google_maps/routing/routes.dart';
// import 'package:provider/provider.dart';

// class ContactCreateView extends StatefulWidget {
//   final ContactEntity? currentContact;

//   const ContactCreateView({super.key, this.currentContact});

//   @override
//   State<ContactCreateView> createState() => _ContactCreateViewState();
// }

// class _ContactCreateViewState extends State<ContactCreateView> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   late TextEditingController _nameController;
//   late TextEditingController _phoneNumberController;
//   late TextEditingController _emailController;

//   @override
//   void initState() {
//     _nameController =
//         TextEditingController(text: widget.currentContact?.name ?? "");
//     _phoneNumberController =
//         TextEditingController(text: widget.currentContact?.phoneNumber ?? "");
//     _emailController =
//         TextEditingController(text: widget.currentContact?.email ?? "");
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneNumberController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   Widget _buildMainContent(CreateContactController controller) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               FieldBox(
//                 title: 'Nome',
//                 inputWidget: TextInput(
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'O nome é obrigatório';
//                     }
//                     return null;
//                   },
//                   controller: _nameController,
//                   hintText: 'Digite o nome completo da pessoa',
//                 ),
//               ),
//               FieldBox(
//                 title: 'Número de telefone',
//                 inputWidget: TextInput(
//                   size: 1,
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'O número de telefone é obrigatório';
//                     }
//                     return null;
//                   },
//                   controller: _phoneNumberController,
//                   hintText: 'Digite o número de telefone',
//                 ),
//               ),
//               FieldBox(
//                 title: 'Email',
//                 inputWidget: TextInput(
//                   size: 1,
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'O email é obrigatório';
//                     }
//                     return null;
//                   },
//                   controller: _emailController,
//                   hintText: 'Digite seu endereço de email',
//                 ),
//               ),
//               FieldBox(
//                 title: 'Foto',
//                 inputWidget: GestureDetector(
//                   onTap: () => controller.pickImage(),
//                   child: Container(
//                     width: 150,
//                     height: 150,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: controller.image == null &&
//                             widget.currentContact == null
//                         ? const Icon(Icons.camera_alt,
//                             size: 50, color: Colors.white)
//                         : (controller.image == null
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: Image.memory(
//                                     base64Decode(widget.currentContact!.image),
//                                     fit: BoxFit.cover),
//                               )
//                             : ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: Image.file(controller.image!,
//                                     fit: BoxFit.cover),
//                               )),
//                   ),
//                 ),
//               ),
//               FieldBox(
//                 title: 'Endereço',
//                 inputWidget: controller.place == null
//                     ? Button(
//                         onPress: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => GoogleMapSearchPlacesApi(
//                                   onSelect: controller.setPlace,
//                                 ), // O widget que você deseja empurrar
//                               ));
//                         },
//                         title: 'Selecionar endereço',
//                         backgroundColor: Colors.greenAccent)
//                     : Text(controller.place!.name),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = Provider.of<CreateContactController>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//             widget.currentContact == null ? 'Novo contato' : 'Editar contato'),
//       ),
//       body: Column(
//         children: [
//           _buildMainContent(controller),
//           const Spacer(),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Button(
//               backgroundColor: AppColors.primaryBlue,
//               onPress: () {
//                 controller.submit(_nameController.text,
//                     _phoneNumberController.text, _emailController.text);
//                 GoRouter.of(context).replace(Routes.contactsList);
//               },
//               title: 'Enviar',
//               isLoading: false,
//             ),
//           ),
//           const Spacer(),
//         ],
//       ),
//     );
//   }
// }
