import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_issue_tracker/presentation/controllers/home_controller.dart';
import 'package:github_issue_tracker/presentation/widgets/issue_list_item.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return WillPopScope(
      onWillPop: () async {
        homeController.clearSearch();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Search Issues',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              fontFamily: GoogleFonts.sourceSans3().fontFamily,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: homeController.searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontFamily: GoogleFonts.sourceSans3().fontFamily),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      homeController.searchController.clear();
                    },
                  ),
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
                ),
                onChanged: (query) {
                  homeController.searchIssues(query);
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                final issues = homeController.issues;
                if (issues.isEmpty) {
                  return Center(
                    child: Text(
                      homeController.errorMessage.value.isNotEmpty
                          ? homeController.errorMessage.value
                          : 'No issues found.',
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: GoogleFonts.sourceSans3().fontFamily),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: issues.length,
                  itemBuilder: (context, index) {
                    final item = issues[index];
                    return IssueListItem(issue: item);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
