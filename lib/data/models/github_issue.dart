import 'package:github_issue_tracker/data/models/user.dart';

class GithubIssue {
  final int id;
  final int number;
  final String title;
  final String state;
  final DateTime createdAt;
  final String body;
  final User user;

  GithubIssue({
    required this.id,
    required this.number,
    required this.title,
    required this.state,
    required this.createdAt,
    required this.body,
    required this.user,
  });

  factory GithubIssue.fromJson(Map<String, dynamic> json) {
    return GithubIssue(
      id: json['id'],
      number: json['number'],
      title: json['title'],
      state: json['state'],
      createdAt: DateTime.parse(json['created_at']),
      body: json['body'],
      user: User.fromJson(json['user']),
    );
  }
}
