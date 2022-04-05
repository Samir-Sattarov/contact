import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/db/specifications.dart';

import 'package:flutter_application_1/model/contact_model.dart';

class GlobalDatabase implements Specification<ContactModel> {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  List<ContactModel> contacts = [];
  final String collection = 'contact';

  @override
  Future create(ContactModel item) async {
    _firebase.collection(collection).add(item.toMap());

    contacts.add(item);
  }

  @override
  Future<List<ContactModel>> getAll() async {
    QuerySnapshot snap = await _firebase.collection(collection).get();
    contacts = [];

    for (var document in snap.docs) {
      String title = document['title'];
      String content = document['content'];
      contacts.add(
        ContactModel(
          title: title,
          phone: content,
          id: document.id,
        ),
      );
    }

    return contacts;
  }

  @override
  Future update(id, ContactModel item) async {
    _firebase.collection(collection).doc(id).update({
      'title': item.title,
      'content': item.phone,
    });

    return 1;
  }

  @override
  Future delete(id) async {
    developer.log("deleted $id");
    await _firebase.collection(collection).doc(id.toString()).delete();
    return id;
  }

  @override
  Future<void> deleteAll() async {
    QuerySnapshot snap = await _firebase.collection(collection).get();
    contacts = [];
    for (var document in snap.docs) {
      delete(document.id);
    }
  }
}
