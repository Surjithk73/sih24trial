import 'package:flutter/material.dart';
import 'package:sih_1/models/contact.dart';
import 'package:sih_1/offline_database/contact_database.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  Future<void> fetchContacts() async {
    final contacts = await DatabaseHelper.instance.getContacts();
    _contacts = contacts;
    notifyListeners();
  }

  Future<void> addContact(String name, String phoneNumber) async {
    final newContact = Contact(name: name, phoneNumber: phoneNumber);
    await DatabaseHelper.instance.insertContact(newContact);
    fetchContacts();
  }

  Future<void> updateContact(Contact contact) async {
    await DatabaseHelper.instance.updateContact(contact);
    fetchContacts();
  }

  Future<void> deleteContact(int id) async {
    await DatabaseHelper.instance.deleteContact(id);
    fetchContacts();
  }
}
