class ContactModel {
  late final String id;
  final String title;
  final String phone;

  ContactModel({dynamic id, required this.title, required this.phone}) {
    this.id = (id ?? DateTime.now().millisecondsSinceEpoch).toString();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id.toString(),
      "title": title.toString(),
      "content": phone.toString(),
    };
  }

  @override
  String toString() {
    return {
      "id": id,
      "title": title,
      "phone": phone,
    }.toString();
  }

  factory ContactModel.fromJson(json) {
    return ContactModel(
      id: json['id'],
      title: json['title'],
      phone: json['phone'],
    );
  }
}
