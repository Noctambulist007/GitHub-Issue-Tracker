import 'package:github_issue_tracker/data/models/github_issue_detail.dart';
import 'package:github_issue_tracker/data/repositories/github_repository.dart';

class GetIssueDetailsUseCase {
  final GithubRepository repository;

  GetIssueDetailsUseCase(this.repository);

  Future<GithubIssueDetail> call(int issueNumber) {
    return repository.getIssueDetails(issueNumber);
  }
}
