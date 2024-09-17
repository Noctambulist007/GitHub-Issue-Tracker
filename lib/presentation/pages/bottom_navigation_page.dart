import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:github_issue_tracker/core/utils/constants.dart';
import 'package:github_issue_tracker/presentation/controllers/bottom_navigation_controller.dart';

class BottomNavigationPage extends GetView<BottomNavigationController> {
  const BottomNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.screens[controller.currentIndex.value]),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: AppColors.primaryColor.withOpacity(0.5),
              selectedLabelStyle: const TextStyle(color: Colors.black),
              unselectedLabelStyle: const TextStyle(color: Colors.black),
              selectedIconTheme:
                  const IconThemeData(color: AppColors.primaryColor),
              unselectedIconTheme:
                  IconThemeData(color: AppColors.primaryColor.withOpacity(0.5)),
              onTap: controller.changeIndex,
              items: [
                _buildBottomNavigationBarItem(
                    'assets/icons/ic-commits.svg', 'Commits', 0),
                _buildBottomNavigationBarItem(
                    'assets/icons/ic-user-profile.svg', 'User Profile', 1),
              ],
            ),
          )
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      String icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Obx(() => SvgPicture.asset(
            icon,
            height: 20,
            color: controller.currentIndex.value == index
                ? AppColors.primaryColor
                : AppColors.primaryColor.withOpacity(0.5),
          )),
      label: label,
    );
  }
}
