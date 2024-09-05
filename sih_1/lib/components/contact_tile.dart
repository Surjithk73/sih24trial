import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactTile extends StatelessWidget {
  final String contactName;
  final String phoneNumber;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ContactTile({
    Key? key,
    required this.contactName,
    required this.phoneNumber,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(contactName),
      background: _buildSwipeRightBackground(),
      secondaryBackground: _buildSwipeLeftBackground(),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // Swipe Left: Confirm Edit or Delete
          return await _showConfirmationDialog(context, onEdit, onDelete);
        } else if (direction == DismissDirection.startToEnd) {
          // Swipe Right: Call
          _callPhoneNumber(phoneNumber);
          return false; // Return false to prevent the tile from being dismissed
        }
        return false;
      },
      child: _buildContactTile(),
    );
  }

  Widget _buildContactTile() {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Text(
        contactName,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(phoneNumber),
      trailing: Icon(Icons.chevron_right),
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildSwipeRightBackground() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      alignment: Alignment.centerLeft,
      color: Colors.green,
      child: Row(
        children: [
          Icon(Icons.call, color: Colors.white),
          SizedBox(width: 8),
          Text(
            'Call',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSwipeLeftBackground() {
    return Container(
      padding: EdgeInsets.only(right: 20),
      alignment: Alignment.centerRight,
      color: Colors.red,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.edit, color: Colors.white),
          SizedBox(width: 16),
          Icon(Icons.delete, color: Colors.white),
        ],
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(
      BuildContext context, VoidCallback onEdit, VoidCallback onDelete) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Choose Action'),
        content: Text('Do you want to edit or delete this contact?'),
        actions: [
          TextButton(
            onPressed: () {
              onEdit();
              Navigator.of(context).pop(true);
            },
            child: Text('Edit'),
          ),
          TextButton(
            onPressed: () {
              onDelete();
              Navigator.of(context).pop(true);
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _callPhoneNumber(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
