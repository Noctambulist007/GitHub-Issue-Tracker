import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:github_issue_tracker/core/widgets/no_internet.dart';

class InternetService extends GetxController {
  static final InternetService _singleton = InternetService._internal();

  InternetService._internal();

  static InternetService get instance => _singleton;

  final _connectivity = Connectivity();
  final RxBool isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _checkInitialConnection();
  }

  Future<void> _checkInitialConnection() async {
    try {
      final connectivityResults = await _connectivity.checkConnectivity();
      _updateConnectionStatus(connectivityResults);
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResults) {
    final connectivityResult = connectivityResults.isNotEmpty
        ? connectivityResults.first
        : ConnectivityResult.none;
    isConnected.value = (connectivityResult != ConnectivityResult.none);

    if (Get.context != null) {
      if (!isConnected.value) {
        if (!(Get.isDialogOpen ?? false)) {
          Get.dialog(
            NoInternetPage(
              onCheckAgain: () {
                Get.back();
                _checkInitialConnection();
              },
            ),
            barrierDismissible: false,
          );
        }
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      }
    }
  }
}
