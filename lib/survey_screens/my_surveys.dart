import 'package:drsya_mobile_app/survey_screens/data/survey_model.dart';
import 'package:drsya_mobile_app/survey_screens/ongoing_surveys.dart';
import 'package:drsya_mobile_app/survey_screens/survey_card_widget.dart';
import 'package:flutter/material.dart';

class MySurveys extends StatefulWidget {
  const MySurveys({super.key});

  @override
  State<MySurveys> createState() => _MySurveysState();
}

class _MySurveysState extends State<MySurveys> {
  List<String> selectedCategories = [];
  List<String> selectedTimeFilters = [];
  List<String> selectedDateFilters = [];

  void _openFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.6,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return StatefulBuilder(
              builder: (context, setModalState) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 32,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(198, 198, 198, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Filters",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        _buildFilterSection(
                            "Categories",
                            Icons.grid_view_outlined,
                            [
                              "All",
                              "Customer Feedback",
                              "Market Research",
                              "Health & Wellness",
                              "Technology & Gadgets",
                              "Travel & Tourism",
                              "Entertainment & Media",
                              "Social & Lifestyle",
                              "Education & Learning"
                            ],
                            selectedCategories,
                            setModalState),
                        _buildFilterSection(
                            "Time to Complete",
                            Icons.hourglass_top_rounded,
                            [
                              "All",
                              "Under 5 minutes",
                              "5-10 minutes",
                              "10-20 minutes",
                              "20+ minutes"
                            ],
                            selectedTimeFilters,
                            setModalState),
                        _buildFilterSection(
                            "Date Posted",
                            Icons.calendar_month_outlined,
                            ["All", "Last 24 Hours", "Last Week", "Last Month"],
                            selectedDateFilters,
                            setModalState),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    ).whenComplete(() => setState(() {})); // Update filters immediately
  }

  Widget _buildFilterSection(String title, IconData icon, List<String> options,
      List<String> selectedList, StateSetter setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 4.0,
          children: [
            Icon(icon, color: Color.fromRGBO(134, 136, 138, 1), size: 16),
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color.fromRGBO(134, 136, 138, 1))),
          ],
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2.9,
          ),
          itemCount: options.length,
          itemBuilder: (context, index) {
            String option = options[index];
            bool isSelected = selectedList.contains(option);
            return GestureDetector(
              onTap: () {
                setModalState(() {
                  if (option == "All") {
                    selectedList.clear();
                    selectedList.add(option);
                  } else {
                    selectedList.remove("All");
                    isSelected
                        ? selectedList.remove(option)
                        : selectedList.add(option);
                  }
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: isSelected
                          ? Color.fromRGBO(243, 111, 52, 1)
                          : Color.fromRGBO(235, 235, 235, 1)),
                  borderRadius: BorderRadius.circular(8),
                  color: isSelected
                      ? Color.fromRGBO(243, 111, 52, 1).withAlpha(20)
                      : Colors.transparent,
                ),
                child: Row(
                  children: [
                    Icon(
                        isSelected
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: isSelected
                            ? Color.fromRGBO(243, 111, 52, 1)
                            : Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Text(option,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                            ))),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Surveys",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_rounded, color: Colors.white),
            onPressed: _openFilterBottomSheet,
          ),
        ],
        backgroundColor: const Color.fromRGBO(5, 30, 41, 1),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (selectedCategories.isNotEmpty ||
                  selectedTimeFilters.isNotEmpty ||
                  selectedDateFilters.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Filtered Results",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selectedCategories.clear();
                              selectedTimeFilters.clear();
                              selectedDateFilters.clear();
                            });
                          },
                          child: const Text(
                            "Clear all filters",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(243, 111, 52, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 4,
                      children: [
                        ...selectedCategories.map((e) => _buildFilterChip(e)),
                        ...selectedTimeFilters.map((e) => _buildFilterChip(e)),
                        ...selectedDateFilters.map((e) => _buildFilterChip(e)),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              OnGoingSureys(
                surveys: dummySurveys,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Available Surveys",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // Prevents double scrolling issue
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Ensures 2 cards per row
                    crossAxisSpacing: 4, // Space between columns
                    mainAxisSpacing: 8, // Space between rows
                    childAspectRatio: 0.65),
                itemCount: dummySurveys.length,
                itemBuilder: (context, index) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return SurveyCard(survey: dummySurveys[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String text) {
    return Chip(
      label: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ), // Adjust text color if needed
      ),
      backgroundColor: Color.fromRGBO(235, 241, 252, 1),

      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.all(
          Radius.circular(18), // Top-left corner rounded
        ),
      ),
      deleteIcon: Icon(Icons.close,
          size: 14, color: Color.fromRGBO(28, 27, 31, 1)), // Delete icon
      onDeleted: () {
        setState(() {
          selectedCategories.remove(text);
          selectedTimeFilters.remove(text);
          selectedDateFilters.remove(text);
        });
      },
    );
  }
}
