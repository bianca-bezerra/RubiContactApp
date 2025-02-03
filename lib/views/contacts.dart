import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps/components/base_list.dart';
import 'package:google_maps/controllers/contact_form_controller.dart';
import 'package:google_maps/models/contact_entity.dart';
import 'package:google_maps/models/contact_repository.dart';
import 'package:google_maps/routing/routes.dart';

class ContactListView extends StatelessWidget {
  final bool isLoading;
  final List<ContactEntity> contacts;
  final Function handleRefresh;

  const ContactListView(
      {super.key,
      required this.isLoading,
      required this.contacts,
      required this.handleRefresh});

  @override
  Widget build(BuildContext context) {
    final contactsRepository = ContactRepository();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      body: SafeArea(
        child: RefreshIndicator(
            child: BaseList<ContactEntity>(
              isLoading: isLoading,
              emptyMessage: "Nenhum contato encontrado!",
              data: contacts,
              itemBuilder: (alert) => ContactItem(
                contact: alert,
                onDelete: (contact) {
                  contactsRepository.deleteContact(contact.id);
                  handleRefresh();
                },
                onEdit: (contact) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactFormController(
                        currentContact: contact,
                      ), // O widget que você deseja empurrar
                    ),
                  );
                },
              ),
            ),
            onRefresh: () => handleRefresh()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push(Routes.createContact);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final ContactEntity contact;
  final Function(ContactEntity) onDelete; // Função de exclusão
  final Function(ContactEntity) onEdit; // Função de edição

  const ContactItem({
    required this.contact,
    required this.onDelete,
    required this.onEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (context) {
              onEdit(contact);
            },
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Editar',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Deletar contato'),
                  content: Text(
                      'Você tem certeza que quer excluir ${contact.name}? Essa ação não poderá ser desfeita!'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        onDelete(contact);

                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Deletar',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Container(
        margin: const EdgeInsets.all(3.0),
        padding: const EdgeInsets.all(3.0),
        child: Row(
          children: [
            // Exibição da imagem do contato
            SizedBox(
              width: 80,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: MemoryImage(
                    base64Decode(contact.image)), // Imagem do contato
              ),
            ),
            const SizedBox(width: 10),

            // Informações do contato (nome, telefone, etc.)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome do contato
                  Text(
                    contact.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 5),

                  // Número de telefone
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.blue, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        contact.phoneNumber,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  // Email do contato
                  Row(
                    children: [
                      const Icon(Icons.email, color: Colors.green, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        contact.email,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Exibição do endereço (latitude e longitude)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Lat: ${contact.address.latitude.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Lng: ${contact.address.longitude.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
