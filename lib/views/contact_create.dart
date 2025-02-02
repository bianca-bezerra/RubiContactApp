import 'package:flutter/material.dart';
import 'package:google_maps/colors.dart';
import 'package:google_maps/components/button.dart';
import 'package:google_maps/components/field_box.dart';
import 'package:google_maps/components/text_input.dart';
import 'package:google_maps/controllers/create_contact_controller.dart';
import 'package:provider/provider.dart';

class ContactCreateView extends StatefulWidget {
  // final VoidCallback onSubmit;
  // final VoidCallback onImagePick;

  const ContactCreateView({
    super.key,
    // required this.onImagePick,
    // required this.onSubmit,
  });

  @override
  State<ContactCreateView> createState() => _ContactCreateViewState();
}

class _ContactCreateViewState extends State<ContactCreateView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Widget _buildMainContent(CreateContactController controller) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Form(
          key: _formKey,
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
                  controller: _nameController,
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
                  controller: _phoneNumberController,
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
                  controller: _emailController,
                  hintText: 'Digite seu endereço de email',
                ),
              ),
              FieldBox(
                title: 'Foto',
                inputWidget: GestureDetector(
                  onTap: () => controller.pickImage(),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: controller.image == null
                        ? const Icon(Icons.camera_alt,
                            size: 50, color: Colors.white)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(controller.image!,
                                fit: BoxFit.cover),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CreateContactController>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Novo contato')),
      body: Column(
        children: [
          _buildMainContent(controller),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Button(
              backgroundColor: AppColors.primaryBlue,
              onPress: ()=>controller.submit(_nameController.text, _phoneNumberController.text, _emailController.text),
              title: 'ENVIAR',
              isLoading: false,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
