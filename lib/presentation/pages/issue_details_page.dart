import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github_issue_tracker/presentation/controllers/issue_details_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class IssueDetailsPage extends GetView<IssueDetailsController> {
  const IssueDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Issue Details',
              style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  fontFamily: GoogleFonts.sourceSans3().fontFamily))),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Lottie.asset('assets/lottie/loading.json',
                repeat: true,
                animate: true,
                width: 55,
                height: 80,
                fit: BoxFit.fill),
          );
        } else if (controller.issue.value != null) {
          final issue = controller.issue.value!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                    text: issue.title,
                    style: GoogleFonts.sourceSans3(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: ' #${issue.number}',
                    style: GoogleFonts.sourceSans3(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 8),
              Row(
                children: [
                  Chip(
                    label: Text(issue.state.toUpperCase()),
                    backgroundColor:
                        issue.state == 'open' ? Colors.green : Colors.red,
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Text('Created: ${issue.formattedCreatedAt}'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(issue.author.avatarUrl!),
                    radius: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(issue.author.login!),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: issue.labels
                    .map((label) => Chip(
                          label: Text(label.name),
                          backgroundColor:
                              Color(int.parse('FF${label.color}', radix: 16)),
                          labelStyle: const TextStyle(color: Colors.white),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              MarkdownBody(
                data: issue.body,
                selectable: true,
                onTapLink: (text, href, title) {
                  if (href != null) {
                    launchUrl(Uri.parse(href));
                  }
                },
              ),
              const SizedBox(height: 16),
              if (issue.comments == 0)
                Text(
                  'No comments available',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontFamily: GoogleFonts.sourceSans3().fontFamily),
                )
              else
                Text(
                  'Comments: ${issue.comments}',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontFamily: GoogleFonts.sourceSans3().fontFamily),
                ),
              const SizedBox(height: 8),
              Text(
                'Last updated: ${issue.formattedUpdatedAt}',
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontFamily: GoogleFonts.sourceSans3().fontFamily),
              ),
              if (issue.closedAt != null)
                Text(
                  'Closed at: ${issue.formattedClosedAt}',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontFamily: GoogleFonts.sourceSans3().fontFamily),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: GoogleFonts.sourceSans3(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => launchUrl(Uri.parse(issue.url)),
                child: Text('View on GitHub',
                    style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontFamily: GoogleFonts.sourceSans3().fontFamily)),
              ),
            ],
          );
        } else if (controller.error.isNotEmpty) {
          return Center(child: Text('Error: ${controller.error.value}'));
        } else {
          return const Center(child: Text('No issue details available'));
        }
      }),
    );
  }
}
