import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'wifi_event.dart';
part 'wifi_state.dart';

class WifiBloc extends Bloc<WifiEvent, WifiState> {

  final Connectivity _connectivity=Connectivity();

  StreamSubscription? connectivitySubscription;

  WifiBloc() : super(WifiInitial()) {
      on<WifiEvent>((event, emit) {
       emit(WifiConnectedState() as WifiState);
      });
      on<WifiEvent>((event, emit) {
        emit(WifiDisconnectedState() as WifiState);
      });
     connectivitySubscription= _connectivity.onConnectivityChanged.listen((result) {
        if (result == ConnectivityResult.wifi) {
          add(WifiConnectedEvent());
        } else {
          add(WifiDisconnectedEvent());
        }
      });
  }
}
