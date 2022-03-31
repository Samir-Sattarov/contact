import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_application_1/bloc/network/network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit(this._connectionStatus, this._connectivity)
      : super(NetworkInitialState()) {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(checkNetwork);
  }
  final ConnectivityResult _connectionStatus;
  final Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  void checkNetwork(ConnectivityResult result) async {
    if (result == ConnectivityResult.wifi) {
      developer.log('connected to wifi');
      emit(ConnectedState());
    } else if (result == ConnectivityResult.none) {
      developer.log('no connection');
      emit(DisconnectedState());
    } else if (result == ConnectivityResult.mobile) {
      developer.log('connected to Mobile Data');
      emit(ConnectedState());
    }
  }
}
