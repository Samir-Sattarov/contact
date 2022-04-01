import 'dart:developer' as developer;

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

    // contactRepository.deleteAll();
    stream.listen(_syncWithLocal);
  }

  Future<void> _syncData(NetworkState status) async {
    if (status is NetworkConnectedState) {
      final lastList = await contactRepository.getAll();
      developer.log("ConnectedState ${lastList.length}");

      // 1 удалить старые данные с Удаленную базы данных
      await contactRepository.deleteAll();

      contactRepository = FireBaseContactRepository();
      await contactRepository.deleteAll();
      // 2 добавить локальные данные в Удаленную базу данных
      for (var model in lastList) {
        await contactRepository.create(model);
      }
      // refresh ui
    }
    await getAll();
  }

  Future<void> _syncWithLocal(List<ContactModel> contacts) async {
    if (networkCubit.state is NetworkConnectedState) {
      developer.log("Преобразование");

      final localRepo = LocalContactRepository();

      await localRepo.deleteAll();
      final remoteRepoDatas = await FireBaseContactRepository().getAll();

      for (var model in remoteRepoDatas) {
        await localRepo.create(model);
      }
      developer.log('Обновление UI');
      // await localRepo.getAll();

      // final localRepo = LocalContactRepository()

      // await localRepo.deleteAll();
      // log('message');

      // for (var model in contacts) {
      //   await localRepo.create(
      //     ContactModel(
      //       title: model.title,
      //       phone: model.phone,
      //     ),
      //   );
      // }
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
    if (query != null && query.toString().isNotEmpty) {
      List<ContactModel> allContacts = await contactRepository.getAll();

      final result = allContacts.where((model) {
        final titlelower = model.title.toLowerCase();
        final phonelower = model.phone.toLowerCase();
        final searchlower = query.toLowerCase();

        return titlelower.contains(searchlower) ||
            phonelower.contains(searchlower);
      }).toList();

      emit(result);
    } else {
      getAll();
    }
  }

  Future getAll() async {
    emit(await contactRepository.getAll());
  }
}
