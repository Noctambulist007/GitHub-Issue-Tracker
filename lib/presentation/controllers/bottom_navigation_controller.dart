import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_issue_tracker/presentation/pages/home_page.dart';
import 'package:github_issue_tracker/presentation/pages/user_profile_page.dart';
import 'package:github_issue_tracker/presentation/controllers/home_controller.dart';

class BottomNavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;

  late final List<Widget> screens;

  @override
  void onInit() {
    super.onInit();
    Get.put(HomeController(
      getIssuesUseCase: Get.find(),
      searchIssuesUseCase: Get.find(),
    ));

    screens = [
      const HomePage(),
      const UserProfilePage(),
    ];
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
