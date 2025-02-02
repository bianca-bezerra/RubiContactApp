import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps/components/base_list.dart';
import 'package:google_maps/models/contact_entity.dart';
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

  const ContactItem({required this.contact, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3.0),
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          // Exibição da imagem do contato
          SizedBox(
            width: 80,
            child: CircleAvatar(
              radius: 30,
              backgroundImage:
                  MemoryImage(base64Decode(contact.image)), // Imagem do contato
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
    );
  }
}
