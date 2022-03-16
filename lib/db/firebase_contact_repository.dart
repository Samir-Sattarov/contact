import 'package:flutter_application_1/db/repository.dart';
import 'package:flutter_application_1/model/contact_model.dart';

class FireBaseContactRepository implements Repository<ContactModel> {
  List<ContactModel> contacts = [];
  @override
  Future<int> create(ContactModel item) async {
    item.id = contacts.length + 1;
    contacts.add(item);
    return item.id ?? 0;
  }

  @override
  Future<List<ContactModel>> getAll() async {
    return contacts;
  }

  @override
  Future<int> delete(int id) async {
    contacts.removeWhere((element) => element.id == id);

    return id;
  }

  @override
  Future<int> update(int id, ContactModel item) async {
    ContactModel contact = contacts.firstWhere((element) => element.id == id);
    contact = item;

    return 1;
  }
}
