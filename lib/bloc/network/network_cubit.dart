import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/network/network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final ConnectivityResult _connectionStatus;
  NetworkCubit(this._connectionStatus, this._connectivity)
      : super(NetworkInitialState()) {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(checkNetwork);
  }
  final Connectivity _connectivity;

  void checkNetwork(ConnectivityResult result) async {
    emit(NetworkSearchingState());
    await Future.delayed(const Duration(seconds: 1, milliseconds: 50))
        .then((value) {
      if (result == ConnectivityResult.wifi) {
        developer.log('connected to wifi');

        emit(NetworkConnectedState());
      } else if (result == ConnectivityResult.none) {
        developer.log('no connection');
        emit(NetworkDisconnectedState());
      } else if (result == ConnectivityResult.mobile) {
        developer.log('connected to Mobile Data');
        emit(NetworkConnectedState());
      }
    });
  }
}
