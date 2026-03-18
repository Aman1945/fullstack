class ContactModel {
  final String id;
  final String name;
  final String email;
  final String message;
  final DateTime createdAt;

  ContactModel({
    required this.id,
    required this.name,
    required this.email,
    required this.message,
    required this.createdAt,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
