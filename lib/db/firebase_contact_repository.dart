import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_application_1/db/repository.dart';
import 'package:flutter_application_1/model/contact_model.dart';

class FireBaseContactRepository implements Repository<ContactModel> {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  List<ContactModel> contacts = [];
  final String collection = 'contact';

  @override
  Future<int> create(ContactModel item) async {
    _firebase.collection(collection).add({'model': item.toMap()});

    contacts.add(item);
    return item.id ?? 0;
  }

  @override
  Future<List<ContactModel>> getAll() async {
    QuerySnapshot snap = await _firebase.collection(collection).get();
    contacts = [];

    snap.docs.forEach(
      (document) {
        print(document.id);
        String title = document.get('model')['title'];
        String content = document.get('model')['content'];
        contacts.add(
          ContactModel(
            title: title,
            phone: content,
            id: document.id,
          ),
        );
      },
    );

    return contacts;
  }

  @override
  Future<int> update(int id, ContactModel item) async {
    print(item.title);
    print(item.phone);

    // ContactModel contact = contacts.firstWhere((element) => element.id == id);
    // contact = item;
    return 1;
  }

  @override
  Future delete(id) async {
    print("deleted $id");
    await _firebase.collection(collection).doc(id.toString()).delete();
    return id;
  }
}
