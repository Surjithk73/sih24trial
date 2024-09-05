import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_1/components/contact_tile.dart';
import 'package:sih_1/models/contact.dart';
import 'package:sih_1/pages/contact/contact_provider.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddContactDialog(context),
          ),
        ],
      ),
      body: Consumer<ContactProvider>(
        builder: (context, contactProvider, child) {
          return ListView.builder(
            itemCount: contactProvider.contacts.length,
            itemBuilder: (context, index) {
              final contact = contactProvider.contacts[index];
              return ContactTile(
                contactName: contact.name,
                phoneNumber: contact.phoneNumber,
                onEdit: () => _showEditContactDialog(context, contact),
                onDelete: () => contactProvider.deleteContact(contact.id!),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    String name = '';
    String phoneNumber = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                onChanged: (value) => phoneNumber = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<ContactProvider>(context, listen: false).addContact(name, phoneNumber);
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showEditContactDialog(BuildContext context, Contact contact) {
    String name = contact.name;
    String phoneNumber = contact.phoneNumber;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                controller: TextEditingController(text: name),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                controller: TextEditingController(text: phoneNumber),
                onChanged: (value) => phoneNumber = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<ContactProvider>(context, listen: false).updateContact(
                  Contact(id: contact.id, name: name, phoneNumber: phoneNumber),
                );
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
