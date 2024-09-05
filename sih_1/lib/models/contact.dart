class Contact {
  final int? id;
  final String name;
  final String phoneNumber;

  Contact({this.id, required this.name, required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
}
