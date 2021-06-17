import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import 'dns_connection_checker.dart';

class NetworkHandler {
  StreamSubscription<ConnectivityResult>? _subscription;
  bool isNetworkAvailable = true;

  void start() async {
    isNetworkAvailable = true;
    await _subscription?.cancel();
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        if (Platform.isAndroid) {
          isNetworkAvailable = await DnsConnectionChecker().hasConnection;
        } else {
          isNetworkAvailable = true;
        }
      }
    });
  }


  void dispose() {
    _subscription?.cancel();
  }
}
