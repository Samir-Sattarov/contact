import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/model/contact_model.dart';

import '../../db/repository.dart';

class ContactCubit extends Cubit<List<ContactModel>> {
  final Repository<ContactModel> contactRepository;

  ContactCubit(this.contactRepository) : super([]);
  void add(title, phone) async {
    await contactRepository
        .create(
          ContactModel(
            title: title,
            phone: phone,
          ),
        )
        .then((value) => getAll());
  }

  void delete(id) async {
    await contactRepository.delete(id);
    await getAll();
  }

  void update(id, title, phone) async {
    ContactModel newModel = ContactModel(
      id: id,
      title: title,
      phone: phone,
    );
    await contactRepository.update(id, newModel);
    await getAll();
  }

  void search(query) async {
    if (query.isEmpty) {
      getAll();
    } else {
      List<ContactModel> allContacts = await contactRepository.getAll();

      final result = allContacts.where((model) {
        final titlelower = model.title.toLowerCase();
        final phonelower = model.phone.toLowerCase();
        final searchlower = query.toLowerCase();

        return titlelower.contains(searchlower) ||
            phonelower.contains(searchlower);
      }).toList();

      emit(result);
    }
  }

  Future<void> getAll() async {
    emit(await contactRepository.getAll());
  }
}
