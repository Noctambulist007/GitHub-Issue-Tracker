import 'package:github_issue_tracker/data/models/user.dart';
import 'package:intl/intl.dart';

class GithubIssueDetail {
  final int id;
  final int number;
  final String title;
  final String state;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? closedAt;
  final String body;
  User author;
  final List<Label> labels;
  final int comments;
  final String url;
  final String repositoryUrl;

  GithubIssueDetail({
    required this.id,
    required this.number,
    required this.title,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    this.closedAt,
    required this.body,
    required this.author,
    required this.labels,
    required this.comments,
    required this.url,
    required this.repositoryUrl,
  });

  factory GithubIssueDetail.fromJson(Map<String, dynamic> json) {
    return GithubIssueDetail(
      id: json['id'],
      number: json['number'],
      title: json['title'],
      state: json['state'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      closedAt:
          json['closed_at'] != null ? DateTime.parse(json['closed_at']) : null,
      body: json['body'] ?? '',
      author: User.fromJson(json['user']),
      labels: (json['labels'] as List)
          .map((label) => Label.fromJson(label))
          .toList(),
      comments: json['comments'],
      url: json['html_url'],
      repositoryUrl: json['repository_url'],
    );
  }

  String get formattedCreatedAt => DateFormat('MMM d, yyyy').format(createdAt);

  String get formattedUpdatedAt => DateFormat('MMM d, yyyy').format(updatedAt);

  String? get formattedClosedAt =>
      closedAt != null ? DateFormat('MMM d, yyyy').format(closedAt!) : null;
}

class Label {
  final int id;
  final String name;
  final String color;
  final String description;

  Label({
    required this.id,
    required this.name,
    required this.color,
    required this.description,
  });

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      description: json['description'] ?? '',
    );
  }
}
