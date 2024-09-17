import 'package:github_issue_tracker/data/models/github_issue.dart';
import 'package:github_issue_tracker/data/repositories/github_repository.dart';

class SearchIssuesUseCase {
  final GithubRepository repository;

  SearchIssuesUseCase(this.repository);

  Future<List<GithubIssue>> call(String query) {
    return repository.searchIssues(query);
  }
}
