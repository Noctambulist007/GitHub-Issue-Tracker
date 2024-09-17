import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_issue_tracker/data/models/user.dart';
import 'package:github_oauth/github_oauth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GitHubController extends GetxController {
  var token = ''.obs;
  var userInfo = Rxn<User>();
  var isLoading = true.obs;

  final GitHubSignIn githubSignIn = GitHubSignIn(
    clientId: dotenv.env['GITHUB_CLIENT_ID']!,
    clientSecret: dotenv.env['GITHUB_CLIENT_SECRET']!,
    redirectUrl: dotenv.env['GITHUB_REDIRECT_URL']!,
  );

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('github_token');
    if (storedToken != null) {
      token.value = storedToken;
      await fetchUserInfo();
    } else {
      isLoading.value = false;
    }
  }

  Future<void> signIn() async {
    isLoading.value = true;

    try {
      final result = await githubSignIn.signIn(Get.context!);

      if (result.status == GitHubSignInResultStatus.ok) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('github_token', result.token!);
        token.value = result.token!;
        await fetchUserInfo();

        Get.snackbar(
          'Success',
          'Signed in successfully',
          backgroundColor: Theme.of(Get.context!).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          colorText: Theme.of(Get.context!).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        );
      } else {
        Get.snackbar('Error', 'Sign-in failed: ${result.errorMessage}',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUserInfo() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.github.com/user'),
        headers: {
          'Authorization': 'token ${token.value}',
        },
      );

      if (response.statusCode == 200) {
        userInfo.value = User.fromJson(json.decode(response.body));
      } else {
        Get.snackbar('Error', 'Failed to load user info',
            backgroundColor: Colors.red, colorText: Colors.white);
        await signOut();
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
      await signOut();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('github_token');
    token.value = '';
    userInfo.value = null;
    isLoading.value = false;
    Get.snackbar(
      'Success',
      'Signed out successfully',
      backgroundColor: Theme.of(Get.context!).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      colorText: Theme.of(Get.context!).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
  }
}
