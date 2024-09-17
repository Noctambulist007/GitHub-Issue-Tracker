import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_service.dart';
import 'core/utils/connectivity_wrapper.dart';
import 'core/utils/internet_service.dart';
import 'data/repositories/github_repository.dart';
import 'domain/usecases/get_issue_details_usecase.dart';
import 'domain/usecases/get_issues_usecase.dart';
import 'domain/usecases/search_issues_usecase.dart';
import 'presentation/controllers/github_controller.dart';
import 'presentation/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final prefs = await SharedPreferences.getInstance();
  Get.put(prefs);
  Get.put(InternetService.instance);

  initializeDependencies();

  runApp(MyApp());
}

void initializeDependencies() {
  Get.put(GitHubController());
  Get.put(GithubRepository());
  Get.put(GetIssuesUseCase(Get.find()));
  Get.put(SearchIssuesUseCase(Get.find()));
  Get.put(GetIssueDetailsUseCase(Get.find()));
}

class MyApp extends StatelessWidget {
  final ThemeService themeService = Get.put(ThemeService());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GitHub Issue Tracker',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeService.theme,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.pages,
      builder: (context, child) {
        return ConnectivityWrapper(child: child!);
      },
    );
  }
}
