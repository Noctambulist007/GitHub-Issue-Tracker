import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:github_issue_tracker/presentation/controllers/home_controller.dart';

class FilterBottomSheet extends StatelessWidget {
  final HomeController controller;

  const FilterBottomSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter and Sort',
                      style: GoogleFonts.sourceSans3(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildFilterSection('State', ['all', 'open', 'closed'],
                        controller.currentState),
                    _buildFilterSection('Sort By', ['created', 'updated'],
                        controller.currentSort),
                    _buildFilterSection('Direction', ['desc', 'asc'],
                        controller.currentDirection),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.refreshIssues();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Apply',
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontFamily:
                                    GoogleFonts.sourceSans3().fontFamily)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
      String title, List<String> options, RxString currentValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.sourceSans3(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => Wrap(
              spacing: 8,
              children: options
                  .map((option) => FilterChip(
                        label: Text(option),
                        selected: currentValue.value == option,
                        onSelected: (selected) {
                          if (selected) {
                            currentValue.value = option;
                            switch (title) {
                              case 'State':
                                controller.updateFilters(state: option);
                                break;
                              case 'Sort By':
                                controller.updateFilters(sort: option);
                                break;
                              case 'Direction':
                                controller.updateFilters(direction: option);
                                break;
                            }
                          }
                        },
                      ))
                  .toList(),
            )),
        const SizedBox(height: 16),
      ],
    );
  }
}
