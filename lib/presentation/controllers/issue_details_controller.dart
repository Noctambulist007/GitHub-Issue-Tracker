import 'package:get/get.dart';
import 'package:github_issue_tracker/data/models/github_issue_detail.dart';
import 'package:github_issue_tracker/domain/usecases/get_issue_details_usecase.dart';

class IssueDetailsController extends GetxController {
  final GetIssueDetailsUseCase _getIssueDetailsUseCase;
  final Rx<GithubIssueDetail?> issue = Rx<GithubIssueDetail?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  IssueDetailsController(
      {required GetIssueDetailsUseCase getIssueDetailsUseCase})
      : _getIssueDetailsUseCase = getIssueDetailsUseCase;

  @override
  void onInit() {
    super.onInit();
    final issueNumber = Get.arguments;
    fetchIssueDetails(issueNumber);
  }

  Future<void> fetchIssueDetails(int issueNumber) async {
    try {
      isLoading.value = true;
      error.value = '';
      final fetchedIssue = await _getIssueDetailsUseCase.call(issueNumber);
      issue.value = fetchedIssue;
    } catch (e) {
      error.value = e.toString();
      print('Error fetching issue details: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
