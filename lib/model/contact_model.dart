class ContactModel {
  int? id;
  final String title;
  final String phone;

  ContactModel({this.id, required this.title, required this.phone});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "title": title,
      "content": phone,
    };
  }

  factory ContactModel.fromJson(json) {
    return ContactModel(
      id: json['id'],
      title: json['title'],
      phone: json['phone'],
    );
  }
}
