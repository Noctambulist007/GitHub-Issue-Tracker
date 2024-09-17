import 'package:get/get.dart';
import 'package:github_issue_tracker/presentation/pages/bottom_navigation_page.dart';
import 'package:github_issue_tracker/presentation/pages/home_page.dart';
import 'package:github_issue_tracker/presentation/pages/issue_details_page.dart';
import 'package:github_issue_tracker/presentation/pages/splash_page.dart';
import 'package:github_issue_tracker/presentation/pages/user_profile_page.dart';
import 'package:github_issue_tracker/presentation/controllers/issue_details_controller.dart';
import 'package:github_issue_tracker/presentation/controllers/bottom_navigation_controller.dart';

class AppRoutes {
  static const splash = '/';
  static const navigation = '/navigation';
  static const home = '/home';
  static const profile = '/profile';
  static const issueDetails = '/issue-details';

  static final pages = [
    GetPage(
      name: splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: navigation,
      page: () => const BottomNavigationPage(),
      binding: BindingsBuilder(() {
        Get.put(BottomNavigationController());
      }),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: profile,
      page: () => const UserProfilePage(),
    ),
    GetPage(
      name: issueDetails,
      page: () => const IssueDetailsPage(),
      binding: BindingsBuilder(() {
        Get.put(IssueDetailsController(
          getIssueDetailsUseCase: Get.find(),
        ));
      }),
      transition: Transition.rightToLeft,
    ),
  ];
}
