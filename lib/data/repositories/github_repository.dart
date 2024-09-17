import 'package:github_issue_tracker/data/models/github_issue.dart';
import 'package:github_issue_tracker/data/models/github_issue_detail.dart';
import 'package:github_issue_tracker/data/providers/github_provider.dart';

class GithubRepository {
  final GithubProvider _provider = GithubProvider();

  Future<List<GithubIssue>> getIssues({
    int page = 1,
    String state = 'all',
    String sort = 'created',
    String direction = 'desc',
  }) =>
      _provider.getIssues(
        page: page,
        state: state,
        sort: sort,
        direction: direction,
      );

  Future<GithubIssueDetail> getIssueDetails(int issueNumber) =>
      _provider.getIssueDetails(issueNumber);

  Future<List<GithubIssue>> searchIssues(String query) =>
      _provider.searchIssues(query);
}
