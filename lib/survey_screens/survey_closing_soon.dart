import 'package:drsya_mobile_app/survey_screens/data/survey_model.dart';
import 'package:drsya_mobile_app/survey_screens/survey_card_widget.dart';
import 'package:flutter/material.dart';

class SurveyClosingSoon extends StatelessWidget {
  final List<SurveyModel> surveys;

  const SurveyClosingSoon({super.key, required this.surveys});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            spacing: 8,
            children: [
              Expanded(
                child: const Text(
                  "Surveys Closing Soon",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              Text(
                "View All",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(243, 111, 52, 1)),
              ),
              Icon(Icons.arrow_forward_ios_rounded,
                  color: Color.fromRGBO(243, 111, 52, 1), size: 16),
            ],
          ),
        ),
        SizedBox(
          height: 224,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: surveys.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: 4), // Set space
            itemBuilder: (context, index) {
              return SurveyCard(survey: surveys[index]);
            },
          ),
        ),
      ],
    );
  }
}
