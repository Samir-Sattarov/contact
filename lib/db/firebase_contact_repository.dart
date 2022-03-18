import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
//    class GlobeCardReporitories {
//   final String _collection = 'globeCardItem';
//   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

//   Future<List<GlobeCard>> getGlobeCard() async {
//     final results = await _fireStore.collection(_collection).get();
//     await Future.delayed(const Duration(seconds: 1));

//     final cards =
//         results.docs.map((e) => GlobeCard.fromJson(e.data())).toList();

//     return cards;
//   }
// }
    DocumentSnapshot snapshot;
    try {
      snapshot = await _firebase.collection(collection).doc().get();
    } catch (error) {
      print(error);
    }

    return contacts;
  }

  @override
  Future<int> delete(int id) async {
    await _firebase.collection(collection).doc(id.toString()).delete();
    print(contacts);
    return id;
  }

  @override
  Future<int> update(int id, ContactModel item) async {
    ContactModel contact = contacts.firstWhere((element) => element.id == id);
    contact = item;
    return 1;
  }
}
