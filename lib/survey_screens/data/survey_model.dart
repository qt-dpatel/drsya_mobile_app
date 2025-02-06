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

final List<SurveyModel> recommondedDummySurvey = [
  SurveyModel(
    clientId: "C001",
    projectId: "P001",
    surveyName: "Workplace Evolution Survey",
    description: "A survey to measure customer satisfaction with our services.",
    startDate: "May 16",
    endDate: "Aug 1",
    responces: '20m 54s',
    status: SurveyStatus.completed,
  ),
  SurveyModel(
    clientId: "C002",
    projectId: "P002",
    surveyName: "Travel Preferences Study",
    description: "A survey to assess employee engagement levels.",
    startDate: "May 16",
    endDate: "Aug 16",
    responces: '10m 4s',
    status: SurveyStatus.completed,
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
    status: SurveyStatus.completed,
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

final List<SurveyModel> dummySurveys = [
  SurveyModel(
    clientId: "C001",
    projectId: "P001",
    surveyName: "Workplace Evolution Survey",
    description: "A survey to measure customer satisfaction with our services.",
    startDate: "May 16",
    endDate: "Aug 1",
    responces: '20m 54s',
    status: SurveyStatus.inProgress,
  ),
  SurveyModel(
    clientId: "C002",
    projectId: "P002",
    surveyName: "Travel Preferences Study",
    description: "A survey to assess employee engagement levels.",
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
