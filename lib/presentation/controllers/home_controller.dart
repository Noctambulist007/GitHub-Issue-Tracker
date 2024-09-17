import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:github_issue_tracker/core/utils/rate_limit_exceeded_exception.dart';
import 'package:github_issue_tracker/domain/usecases/get_issues_usecase.dart';
import 'package:github_issue_tracker/domain/usecases/search_issues_usecase.dart';
import '../../data/models/github_issue.dart';
import '../widgets/filter_bottom_sheet.dart';

class HomeController extends GetxController {
  final GetIssuesUseCase _getIssuesUseCase;
  final SearchIssuesUseCase _searchIssuesUseCase;

  HomeController({
    required GetIssuesUseCase getIssuesUseCase,
    required SearchIssuesUseCase searchIssuesUseCase,
  })  : _getIssuesUseCase = getIssuesUseCase,
        _searchIssuesUseCase = searchIssuesUseCase;

  final RxList<GithubIssue> issues = <GithubIssue>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMoreIssues = true.obs;
  final RxString errorMessage = ''.obs;
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final RxBool isSearching = false.obs;
  int currentPage = 1;

  final RxString currentState = 'all'.obs;
  final RxString currentSort = 'created'.obs;
  final RxString currentDirection = 'desc'.obs;

  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(onScroll);
    searchController.addListener(onSearchChanged);
    fetchIssues();
  }

  @override
  void onClose() {
    scrollController.removeListener(onScroll);
    searchController.removeListener(onSearchChanged);
    scrollController.dispose();
    searchController.dispose();
    _debounce?.cancel();
    super.onClose();
  }

  void onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (!isSearching.value) {
        fetchIssues();
      }
    }
  }

  void onSearchChanged() {
    print('Search text changed: ${searchController.text}');
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (searchController.text.isEmpty) {
        isSearching.value = false;
        refreshIssues();
      } else {
        isSearching.value = true;
        searchIssues(searchController.text);
      }
    });
  }

  Future<void> fetchIssues({bool refresh = false}) async {
    if (refresh) {
      currentPage = 1;
      issues.clear();
      hasMoreIssues.value = true;
    }

    if (!hasMoreIssues.value || isLoading.value) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final fetchedIssues = await _getIssuesUseCase.call(
        page: currentPage,
        state: currentState.value,
        sort: currentSort.value,
        direction: currentDirection.value,
      );

      final filteredIssues = fetchedIssues.where((issue) =>
      !issue.title.toLowerCase().contains('flutter')).toList();

      if (filteredIssues.isEmpty) {
        hasMoreIssues.value = false;
      } else {
        final uniqueIssues = filteredIssues.where((issue) =>
        !issues.any((existingIssue) => existingIssue.id == issue.id));

        if (uniqueIssues.isNotEmpty) {
          issues.addAll(uniqueIssues);
          currentPage++;
        } else {
          hasMoreIssues.value = false;
        }
      }
    } on RateLimitExceededException catch (e) {
      errorMessage.value = e.toString();
      hasMoreIssues.value = false;
    } catch (e) {
      errorMessage.value = 'Failed to fetch issues. Please try again later.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshIssues() async {
    await fetchIssues(refresh: true);
  }

  Future<void> searchIssues(String query) async {
    if (query.isEmpty) {
      await refreshIssues();
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final searchResults = await _searchIssuesUseCase.call(query);

      final filteredSearchResults = searchResults
          .where((issue) => !issue.title.toLowerCase().contains('flutter'))
          .toList();

      issues.assignAll(filteredSearchResults);

      if (filteredSearchResults.isEmpty) {
        errorMessage.value = 'No results found for "$query"';
      }
    } catch (e) {
      errorMessage.value = 'Failed to search issues. Please try again later.';
    } finally {
      isLoading.value = false;
    }
  }

  void updateFilters({String? state, String? sort, String? direction}) {
    if (state != null) currentState.value = state;
    if (sort != null) currentSort.value = sort;
    if (direction != null) currentDirection.value = direction;
    refreshIssues();
  }
  void clearSearch() {
    searchController.clear();
    issues.clear();
    errorMessage.value = '';
    isSearching.value = false;
  }

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.pop(context),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: FilterBottomSheet(controller: this),
          ),
        );
      },
    );
  }
}
