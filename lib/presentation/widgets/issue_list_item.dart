import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_issue_tracker/core/widgets/format_date.dart';
import 'package:github_issue_tracker/data/models/github_issue.dart';
import 'package:google_fonts/google_fonts.dart';

class IssueListItem extends StatelessWidget {
  final GithubIssue issue;

  const IssueListItem({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed('/issue-details', arguments: issue.number),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    issue.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: GoogleFonts.sourceSans3().fontFamily),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  formatDate(issue.createdAt),
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontFamily: GoogleFonts.sourceCodePro().fontFamily),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(issue.user.avatarUrl!),
                  radius: 15,
                ),
                const SizedBox(width: 8),
                Text(
                  issue.user.login!,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontFamily: GoogleFonts.sourceCodePro().fontFamily),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
