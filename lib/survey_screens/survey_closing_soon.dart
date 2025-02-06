import 'package:flutter/material.dart';

class SurveyClosingSoon extends StatelessWidget {
  final List<SurveyModel> surveys;

  const SurveyClosingSoon({super.key, required this.surveys});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 8,
            children: [
              Expanded(
                child: const Text(
                  "Surveys Closing Soon",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Text(
                "View All",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
              return _buildCampaignCard(surveys[index], context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCampaignCard(SurveyModel survey, BuildContext context) {
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
        width: 182,
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

enum SurveyStatus { completed, inProgress, scheduled }

class SurveyModel {
  final String? clientId; // ID of the client
  final String? projectId; // ID of the project
  final String surveyName; // Name of the campaign
  final String description; // Description of the campaign
  final String startDate; // Start date of the campaign
  final String endDate; // End date of the campaign
  final String responces; // Number of surveys in the campaign
  final SurveyStatus status; // Status of the campaign

  SurveyModel({
    this.clientId,
    this.projectId,
    required this.surveyName,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.responces = "",
    required this.status,
  });

  // Factory constructor for creating a Campaign object from JSON
  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return SurveyModel(
      clientId: json['clientId'] as String?,
      projectId: json['projectId'] as String?,
      surveyName: json['surveyName'] as String,
      description: json['description'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      status: SurveyStatus.scheduled,
    );
  }

  // Method for converting a Campaign object to JSON
  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'projectId': projectId,
      'surveyName': surveyName,
      'description': description,
      'startDate': DateTime.parse(startDate).toIso8601String(),
      'endDate': DateTime.parse(endDate).toIso8601String(),
    };
  }

  // Method for printing campaign details (optional)
  @override
  String toString() {
    return '''
    Survey(
      clientId: $clientId,
      projectId: $projectId,
      surveyName: $surveyName,
      description: $description,
      startDate: $startDate,
      endDate: $endDate,
    )
    ''';
  }
}

final List<SurveyModel> surveysClosingSoon = [
  SurveyModel(
    clientId: "C001",
    projectId: "P001",
    surveyName: "Entertainment Choices Survey",
    description:
        "Uncover trends in media consumption and leisure activities. Help us learn about favorite shows, games, and platforms shaping entertainment habits this year.",
    startDate: "May 16",
    endDate: "Aug 1",
    responces: '20m 54s',
    status: SurveyStatus.inProgress,
  ),
  SurveyModel(
    clientId: "C002",
    projectId: "P002",
    surveyName: "Sustainable Living Insights",
    description:
        "Investigate how sustainability impacts everyday decisions. Share your experiences with eco-friendly practices, green products, and conscious living choices.",
    startDate: "May 16",
    endDate: "Aug 16",
    responces: '10m 4s',
    status: SurveyStatus.inProgress,
  ),
  SurveyModel(
    clientId: "C003",
    projectId: "P003",
    surveyName: "Product Feedback Survey",
    description:
        "Collecting feedback on the newly launched product.Collecting feedback on the newly launched product.Collecting feedback on the newly launched product.Collecting feedback on the newly launched product",
    startDate: "May 16",
    endDate: "Aug 16",
    responces: '20m54s',
    status: SurveyStatus.inProgress,
  ),
  SurveyModel(
    clientId: "C004",
    projectId: "P004",
    surveyName: "Market Research Survey",
    description: "Researching market trends for upcoming projects.",
    startDate: "May 16",
    endDate: "Aug 16",
    responces: '20m54s',
    status: SurveyStatus.inProgress,
  ),
  SurveyModel(
    clientId: "C005",
    projectId: "P005",
    surveyName: "Training Feedback Survey",
    description: "Evaluating feedback from a recent training program.",
    startDate: "May 16, 2023",
    endDate: "Aug 16, 2023",
    responces: '20m54s',
    status: SurveyStatus.inProgress,
  ),
  SurveyModel(
    clientId: "C006",
    projectId: "P006",
    surveyName: "Website Usability Survey",
    description: "Assessing user experience on our website.",
    startDate: "May 16, 2023",
    endDate: "Aug 16, 2023",
    responces: '20m54s',
    status: SurveyStatus.inProgress,
  ),
];
