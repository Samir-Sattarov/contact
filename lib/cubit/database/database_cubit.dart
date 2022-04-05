import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/cubit/network/network_cubit.dart';
import 'package:flutter_application_1/cubit/network/network_state.dart';

import 'package:flutter_application_1/db/global_database.dart';
import 'package:flutter_application_1/db/local_database.dart';
import 'package:flutter_application_1/db/specifications.dart';
import 'package:flutter_application_1/model/contact_model.dart';

class DatabaseCubit extends Cubit<List<ContactModel>> {
  Specification<ContactModel> contactRepository;
  final NetworkCubit networkCubit;

  DatabaseCubit(this.contactRepository, this.networkCubit) : super([]) {
    networkCubit.stream.listen(_syncData);
    stream.listen(_syncWithLocal);
  }

  Future<void> _syncData(NetworkState status) async {
    if (status is NetworkConnectedState) {
      final lastList = await contactRepository.getAll();
      developer.log("ConnectedState ${lastList.length}");

      // 1 удалить старые данные с Удаленной базы данныых
      await contactRepository.deleteAll();

      contactRepository = GlobalDatabase();
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
      final globalRepo = GlobalDatabase();
      final localRepo = LocalDatabase();
      await localRepo.deleteAll();
      final remoteRepoDatas = await globalRepo.getAll();

      for (var model in remoteRepoDatas) {
        await localRepo.create(model);
        developer.log("Синхронизация");
      }
      final localData = await localRepo.getAll();
      final globalData = await globalRepo.getAll();

      developer.log('local ${localData.length} global ${globalData.length}');
    }
  }

  void add(title, phone) async {
    await contactRepository.create(
      ContactModel(
        title: title,
        phone: phone,
      ),
    );
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
    emit(
      await contactRepository.getAll(),
    );
  }

  Future deleteAllFromAllDatabase() async {
    final localDatabase = LocalDatabase();
    final globalDatabase = GlobalDatabase();

    await localDatabase.deleteAll();
    await globalDatabase.deleteAll();

    final localData = await localDatabase.getAll();
    final globalData = await globalDatabase.getAll();

    developer.log(
      'removed from all db local ${localData.length} global ${globalData.length}',
    );

    await getAll();
  }
}
