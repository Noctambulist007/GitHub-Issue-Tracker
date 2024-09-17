import 'package:github_issue_tracker/data/models/github_issue.dart';
import 'package:github_issue_tracker/data/repositories/github_repository.dart';

class GetIssuesUseCase {
  final GithubRepository repository;

  GetIssuesUseCase(this.repository);

  Future<List<GithubIssue>> call({
    int page = 1,
    String state = 'all',
    String sort = 'created',
    String direction = 'desc',
  }) {
    return repository.getIssues(
        page: page, state: state, sort: sort, direction: direction);
  }
}
