import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:flutter_application_1/bloc/network/network_cubit.dart';
import 'package:flutter_application_1/bloc/network/network_state.dart';
import 'package:flutter_application_1/db/firebase_contact_repository.dart';
import 'package:flutter_application_1/db/local_contact_repository.dart';
import 'package:flutter_application_1/model/contact_model.dart';

import '../../db/repository.dart';

class ContactCubit extends Cubit<List<ContactModel>> {
  Repository<ContactModel> contactRepository;
  final NetworkCubit networkCubit;

  ContactCubit(this.contactRepository, this.networkCubit) : super([]) {
    networkCubit.stream.listen(_syncData);
    contactRepository.deleteAll();

    stream.listen(syncWithLocal);
  }

  Future<void> _syncData(NetworkState state) async {
    if (state is ConnectedState) {
      final lastList = await contactRepository.getAll();
      log("ConnectedState ${lastList.length}");

      await contactRepository.deleteAll();

      // 1 удалить старые данные с Удаленную базы данных

      contactRepository = FireBaseContactRepository();
      await contactRepository.deleteAll();
      // 2 добавить локальные данные в Удаленную базу данных
      lastList.forEach((element) async {
        await contactRepository.create(element);
      });
      // refresh ui
      await getAll();
    }
    if (state is DisconnectedState) {
      contactRepository = LocalContactRepository();
      log('disconnected');

      await getAll();
    }
  }

  Future<void> syncWithLocal(List<ContactModel> contacts) async {
    if (networkCubit.state is ConnectedState) {
      final repo = LocalContactRepository();
      await repo.deleteAll();
      log('Deleted All');

      contacts.forEach((element) async {
        await repo.create(element);
      });
    }
  }

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
