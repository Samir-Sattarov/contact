import 'dart:developer';

import 'package:flutter_application_1/bloc/network/network_cubit.dart';
import 'package:flutter_application_1/bloc/network/network_state.dart';
import 'package:flutter_application_1/bloc/ui/snackbar/snackbar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SnackBarCubit extends Cubit<SnackBarState> {
  final NetworkCubit networkCubit;

  SnackBarCubit(
    this.networkCubit,
  ) : super(SnackBarInitialState()) {
    networkCubit.stream.listen(fooSnackbar);
  }

  void fooSnackbar(NetworkState status) {
    emit(SnackBarInitialState());

    if (status is NetworkConnectedState) {
      log('snackbar on');
      emit(SnackBarShowState());
    } else if (status is NetworkDisconnectedState) {
      log('snackbar off');
      emit(SnackBarHideState());
    }
  }
}
