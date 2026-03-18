class ContactModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String message;
  final DateTime createdAt;

  ContactModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.message,
    required this.createdAt,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
