import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_issue_tracker/core/widgets/loading_widget.dart';
import 'package:github_issue_tracker/data/models/user.dart';
import 'package:github_issue_tracker/presentation/controllers/github_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfilePage extends GetView<GitHubController> {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              fontFamily: GoogleFonts.sourceSans3().fontFamily,
            )),
        actions: [
          Obx(() {
            if (controller.token.isNotEmpty) {
              return IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => _showLogoutConfirmation(
                  context,
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingWidget();
        } else if (controller.token.isEmpty) {
          return buildSignInButton(context);
        } else if (controller.userInfo.value == null) {
          return const Center(child: Text('Failed to load user info'));
        } else {
          return buildUserProfile(controller.userInfo.value!);
        }
      }),
    );
  }

  Widget buildSignInButton(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'To see user profile, please sign in.',
            style: TextStyle(
              fontSize: 16.0,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              fontFamily: GoogleFonts.sourceSans3().fontFamily,
            ),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () => controller.signIn(),
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/logo/github_mark_white.png',
                  width: 24.0,
                  height: 24.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Sign in with GitHub',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontFamily: GoogleFonts.sourceSans3().fontFamily,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserProfile(User user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(user.avatarUrl ?? ''),
              ),
              const SizedBox(height: 20),
              Text(
                user.name ?? 'No name available',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.sourceSans3().fontFamily,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '@${user.login ?? 'No username'}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(Get.context!).brightness == Brightness.dark
                      ? Colors.white54
                      : Colors.grey,
                  fontFamily: GoogleFonts.sourceSans3().fontFamily,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Bio: ${user.bio ?? 'No bio available'}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: GoogleFonts.sourceSans3().fontFamily,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Public Repos: ${user.publicRepos ?? 0}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: GoogleFonts.sourceSans3().fontFamily,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Public Gists: ${user.publicGists ?? 0}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: GoogleFonts.sourceSans3().fontFamily,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Private Repos: ${user.totalPrivateRepos ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: GoogleFonts.sourceSans3().fontFamily,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        final isDarkMode = theme.brightness == Brightness.dark;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[850] : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color:
                    isDarkMode ? Colors.black54 : Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[600] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Icon(
                Icons.logout,
                size: 50,
                color: theme.primaryColor,
              ),
              const SizedBox(height: 20),
              Text(
                'Logout Confirmation',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.sourceSans3().fontFamily,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Are you sure you want to logout?',
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  fontFamily: GoogleFonts.sourceSans3().fontFamily,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isDarkMode ? Colors.grey[700] : Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: 14,
                          fontFamily: GoogleFonts.sourceSans3().fontFamily,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.signOut();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: GoogleFonts.sourceSans3().fontFamily,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
