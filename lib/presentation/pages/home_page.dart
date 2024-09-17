import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_issue_tracker/core/theme/theme_service.dart';
import 'package:github_issue_tracker/core/widgets/loading_widget.dart';
import 'package:github_issue_tracker/presentation/controllers/home_controller.dart';
import 'package:github_issue_tracker/presentation/pages/search_page.dart';
import 'package:github_issue_tracker/presentation/widgets/empty_issues.dart';
import 'package:github_issue_tracker/presentation/widgets/issue_list_item.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Row(
            children: [
              Text(
                'Flutter Commit List (${controller.issues.length})',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: GoogleFonts.sourceSans3().fontFamily,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'master',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: GoogleFonts.sourceSans3().fontFamily,
                  ),
                ),
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => controller.showFilterBottomSheet(context),
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => Get.find<ThemeService>().switchTheme(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Get.to(
                  () => const SearchPage(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 500),
                );
              },
              child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'Search issues...',
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    prefixIcon:
                        Icon(Icons.search, color: Theme.of(context).hintColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                          color: Theme.of(context).dividerColor, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2.0),
                    ),
                  )),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.issues.isEmpty) {
                return const Center(child: LoadingWidget());
              } else if (controller.errorMessage.isNotEmpty) {
                return Center(
                  child: Column(
                    children: [
                      Text(
                        controller.errorMessage.value,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          controller.refreshIssues();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (controller.issues.isEmpty) {
                return EmptyIssuesWidget(onRefresh: controller.refreshIssues);
              } else {
                return RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  onRefresh: controller.refreshIssues,
                  child: ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.issues.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.issues.length) {
                        final issue = controller.issues[index];
                        return Column(
                          children: [
                            IssueListItem(issue: issue),
                            const Divider(thickness: 1),
                          ],
                        );
                      } else if (controller.hasMoreIssues.value) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: LoadingWidget(),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
