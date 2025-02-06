import 'package:drsya_mobile_app/survey_screens/data/survey_model.dart';
import 'package:flutter/material.dart';

class SurveyCard extends StatelessWidget {
  final SurveyModel survey;
  const SurveyCard({super.key, required this.survey});

  @override
  Widget build(BuildContext context) {
    IconData statusIcon;
    Color statusColor;
    Color statusBackgroundColor;
    switch (survey.status) {
      case SurveyStatus.completed:
        statusIcon = Icons.check_rounded;
        statusColor = const Color.fromRGBO(134, 136, 138, 1);
        statusBackgroundColor = const Color.fromRGBO(214, 238, 221, 1);
        break;
      case SurveyStatus.inProgress:
        statusIcon = Icons.hourglass_top_rounded;
        statusColor = const Color.fromRGBO(243, 111, 52, 1);
        statusBackgroundColor = const Color.fromRGBO(252, 212, 195, 1);
        break;
      case SurveyStatus.scheduled:
        statusIcon = Icons.calendar_today_rounded;
        statusColor = const Color.fromRGBO(5, 30, 41, 1);
        statusBackgroundColor = const Color.fromRGBO(235, 235, 235, 1);
        break;
    }
    return GestureDetector(
      onTap: () {
        // Open project details
      },
      child: SizedBox(
        width: 172,
        height: 220,
        child: Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: const Color.fromRGBO(255, 255, 255, 1),
          elevation: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Icon and Project Name

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            // Circular background for suitcase icon
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(255, 249, 223, 1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.bar_chart,
                                color: Color.fromRGBO(241, 196, 15, 1),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                survey.surveyName,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Date Range
                      Text(
                        "${survey.startDate} - ${survey.endDate}",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                ),
              ),

              const Divider(
                height: 1,
                color: Color.fromRGBO(242, 242, 242, 1),
              ),
              // Description
              Expanded(
                child: Container(
                  color: const Color.fromRGBO(250, 250, 250, 1),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            survey.description,
                            style: const TextStyle(color: Colors.black54),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      // Status and Metrics
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8.0),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Status Icon
                              Row(
                                children: [
                                  Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: statusBackgroundColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(statusIcon,
                                          color: statusColor, size: 20)),
                                  const SizedBox(width: 4),
                                  Text(survey.responces.toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
