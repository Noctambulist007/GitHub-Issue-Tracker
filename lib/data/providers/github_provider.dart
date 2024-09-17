import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_issue_tracker/core/utils/rate_limit_exceeded_exception.dart';
import 'package:github_issue_tracker/data/models/github_issue.dart';
import 'package:github_issue_tracker/data/models/github_issue_detail.dart';
import 'package:http/http.dart' as http;

class GithubProvider {
  final String _baseUrl = 'https://api.github.com/repos/flutter/flutter/issues';
  final String? _token = dotenv.env['GITHUB_TOKEN'];
  final int _perPage = 30;

  Future<List<GithubIssue>> getIssues({
    int page = 1,
    String state = 'all',
    String sort = 'created',
    String direction = 'desc',
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$_baseUrl?page=$page&per_page=$_perPage&state=$state&sort=$sort&direction=$direction'),
        headers: {
          'Accept': 'application/vnd.github.v3+json',
          if (_token != null) 'Authorization': 'token $_token',
        },
      );

      if (response.statusCode == 200) {
        final List issuesJson = json.decode(response.body);
        return issuesJson.map((json) => GithubIssue.fromJson(json)).toList();
      } else if (response.statusCode == 403 &&
          response.headers['x-ratelimit-remaining'] == '0') {
        final resetTime =
            int.parse(response.headers['x-ratelimit-reset'] ?? '0');
        final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        final waitTime = resetTime - currentTime;
        throw RateLimitExceededException(waitTime);
      } else {
        throw Exception('Failed to load issues: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching issues: $e');

      rethrow;
    }
  }

  Future<GithubIssueDetail> getIssueDetails(int issueNumber) async {
    final url = Uri.parse(
        'https://api.github.com/repos/flutter/flutter/issues/$issueNumber');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/vnd.github.v3+json',
        if (_token != null) 'Authorization': 'token $_token',
      },
    );

    if (response.statusCode == 200) {
      return GithubIssueDetail.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception(
          'Issue #$issueNumber not found. Please check the issue number.');
    } else {
      final errorBody = json.decode(response.body);
      throw Exception('Failed to load issue details: ${errorBody['message']}');
    }
  }

  Future<List<GithubIssue>> searchIssues(String query) async {
    final url = Uri.parse(
        'https://api.github.com/search/issues?q=$query+repo:flutter/flutter');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/vnd.github.v3+json',
        if (_token != null) 'Authorization': 'token $_token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List issuesJson = jsonResponse['items'];
      return issuesJson.map((json) => GithubIssue.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search issues');
    }
  }
}
