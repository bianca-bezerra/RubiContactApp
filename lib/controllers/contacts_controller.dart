import 'package:flutter/material.dart';
import 'package:google_maps/models/contact_entity.dart';
import 'package:google_maps/models/contact_repository.dart';
import 'package:google_maps/views/contacts.dart';

class ContactListController extends StatefulWidget {
  const ContactListController({super.key});

  @override
  State<ContactListController> createState() => _ContactListControllerState();
}

class _ContactListControllerState extends State<ContactListController> {
  late ContactRepository _contactRepository;

  List<ContactEntity> contacts = [];
  List<ContactEntity> fetchedContacts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _contactRepository = ContactRepository();

    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await _contactRepository.getMockContactList();
      setState(() {
        contacts = result;
        fetchedContacts = result;
      });
    } catch (e) {
      setState(() {
        contacts = [];
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContactListView(
      contacts: contacts,
      isLoading: isLoading,
      handleRefresh: _fetchContacts,
    );
  }
}
