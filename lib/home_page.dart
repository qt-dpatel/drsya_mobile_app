import 'package:drsya_mobile_app/categories.dart';
import 'package:drsya_mobile_app/new_servey.dart';
import 'package:drsya_mobile_app/recommonded_survey.dart';
import 'package:drsya_mobile_app/survey_card.dart';
import 'package:drsya_mobile_app/survey_closing_soon.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final ScrollController scrollController;
  const HomePage({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NewSurveys(),
          Categories(),
          SurveyListPage(
            surveys: dummySurveys,
          ),
          SurveyClosingSoon(surveys: surveysClosingSoon),
          RecommondedSurvey(surveys: recommondedDummySurvey),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
