import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_issue_tracker/core/widgets/no_internet.dart';

import 'internet_service.dart';

class ConnectivityWrapper extends StatelessWidget {
  final Widget child;

  const ConnectivityWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GetX<InternetService>(
      builder: (controller) {
        if (controller.isConnected.value) {
          return child;
        } else {
          return const NoInternetPage();
        }
      },
    );
  }
}
