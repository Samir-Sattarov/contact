class ListTileModel {
  final int? id;
  final String title;
  final String phone;

  ListTileModel({this.id, required this.title, required this.phone});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "title": title,
      "content": phone,
    };
  }
}
