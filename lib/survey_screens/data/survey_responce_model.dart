import 'package:flutter/material.dart';

final Map<String, TextEditingController> textControllers = {};
final Map<String, dynamic> userResponses = {};

class Survey {
  final String surveyName;
  final String startDate;
  final List<SurveyElement> elements;

  Survey({
    required this.surveyName,
    required this.startDate,
    required this.elements,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      surveyName: json['surveyName'],
      startDate: json['startDate'],
      elements: (json['elements'] as List)
          .map((e) => SurveyElement.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surveyName': surveyName,
      'startDate': startDate,
      'elements': elements.map((e) => e.toJson()).toList(),
    };
  }
}

// A handle section, composer, and question.
abstract class SurveyElement {
  String id;
  String type;

  SurveyElement({required this.id, required this.type});

  factory SurveyElement.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'section':
        return Section.fromJson(json);
      case 'composer':
        return Composer.fromJson(json);
      default:
        return Question.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();
  SurveyElement copyWith({
    String? id,
    String? type,
  });
}

// Section Model
class Section extends SurveyElement {
  String? title;
  String? description;
  bool isEditing; // Indicates if the section is in edit mode

  Section({
    required super.id,
    this.title = '',
    this.description = '',
    this.isEditing = true, // Default to editing mode
  }) : super(type: 'section');

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
    };
  }

  @override
  Section copyWith({
    String? id,
    String? type,
    String? title,
    String? description,
    bool? isEditing,
  }) {
    return Section(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}

// Composer Model
class Composer extends SurveyElement {
  String title;
  List<Question> children;
  bool isEditing; // Indicates if the section is in edit mode

  Composer({
    required super.id,
    required this.title,
    required this.children,
    this.isEditing = true, // Default to editing mode
  }) : super(type: 'composer');

  factory Composer.fromJson(Map<String, dynamic> json) {
    return Composer(
      id: json['id'],
      title: json['title'],
      children: (json['children'] as List)
          .map((child) => Question.fromJson(child))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'children': children.map((c) => c.toJson()).toList(),
    };
  }

  @override
  Composer copyWith({
    String? id,
    String? type,
    String? title,
    List<Question>? children,
    bool? isEditing,
  }) {
    return Composer(
      id: id ?? this.id,
      title: title ?? this.title,
      children: children ?? this.children,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}

// Question Model

class Question extends SurveyElement {
  String questionText; // Main question text
  String? subtitle; // Optional subtitle
  Map<String, String?>?
      branching; // Branching logic (option -> target question ID)
  List<String>? options; // Options for 'radio' types
  dynamic answer; // Placeholder for admin-created default values (if needed)
  bool get isBranchable =>
      type == 'radio' || type == 'nps'; // Only applicable for specific types
  bool isVisible;
  bool isEditing; // Indicates if the section is in edit mode
  FileUpload? fileUpload; // File upload metadata (optional)
// Predefined ranges for NPS questions
  static const List<String> npsRanges = ['0-6', '7-8', '9-10'];
//csat
  String csatStartName;
  String csatEndName;
  int csatStart; // Start of CSAT scale
  int csatEnd; // End of CSAT scale
  Question({
    required super.id,
    required super.type,
    required this.questionText,
    this.subtitle,
    this.branching,
    this.options,
    this.answer,
    this.isVisible = true, // Default to hidden
    this.isEditing = true, // Default to editing mode
    this.fileUpload,
    this.csatStart = 0,
    this.csatEnd = 10,
    this.csatStartName = 'less Likely',
    this.csatEndName = 'most Likely',
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      type: json['type'],
      questionText: json['questionText'],
      subtitle: json['subtitle'],
      branching: json['branching'] != null
          ? Map<String, String>.from(json['branching'])
          : null,
      options:
          (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
      answer: json['answer'],
      isVisible: json['type'] == 'section', // Sections are always visible
      fileUpload: json['fileUpload'] != null
          ? FileUpload.fromJson(json['fileUpload'])
          : null,

      csatStart: json['csatStart'],
      csatEnd: json['csatEnd'],
      csatStartName: json['csatStartName'],
      csatEndName: json['csatEndName'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'subtitle': subtitle,
      'questionText': questionText,
      'branching': branching,
      'options': options,
      'answer': answer,
      'fileUpload': fileUpload?.toJson(),
      'csatStart': csatStart,
      'csatEnd': csatEnd,
      'csatStartName': csatStartName,
      'csatEndName': csatEndName,
    };
  }

  // Copy constructor for immutability
  @override
  Question copyWith({
    String? id,
    String? type,
    String? questionText,
    String? subtitle,
    List<String>? options,
    int? sequence,
    int? displaySeq,
    Map<String, String?>? branching,
    dynamic answer,
    bool? isEditing,
    FileUpload? fileUpload,
    int? csatStart, // Start of CSAT scale
    int? csatEnd, // End of CSAT scale
    String? csatStartName,
    String? csatEndName,
  }) {
    return Question(
      id: id ?? this.id,
      type: type ?? this.type,
      questionText: questionText ?? this.questionText,
      subtitle: subtitle ?? this.subtitle,
      options: options ?? this.options,
      branching: branching ?? this.branching,
      answer: answer ?? this.answer,
      isEditing: isEditing ?? this.isEditing,
      fileUpload: fileUpload ?? this.fileUpload,
      csatStart: csatStart ?? this.csatStart,
      csatEnd: csatEnd ?? this.csatEnd,
      csatStartName: csatStartName ?? this.csatStartName,
      csatEndName: csatEndName ?? this.csatEndName,
    );
  }
}

// FileUpload model
class FileUpload {
  final String? fileType; // "Video", "Audio", "Image"
  final String? uploadedFileUrl; // URL or path of the uploaded file
  final String? maxFileSize; // Maximum allowed file size (e.g., "10 MB")

  FileUpload({
    this.fileType,
    this.uploadedFileUrl,
    this.maxFileSize,
  });

  factory FileUpload.fromJson(Map<String, dynamic> json) {
    return FileUpload(
      fileType: json['fileType'],
      uploadedFileUrl: json['uploadedFileUrl'],
      maxFileSize: json['maxFileSize'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileType': fileType,
      'uploadedFileUrl': uploadedFileUrl,
      'maxFileSize': maxFileSize,
    };
  }

  // Copy constructor for immutability
  FileUpload copyWith({
    String? fileType,
    String? uploadedFileUrl,
    String? maxFileSize,
  }) {
    return FileUpload(
      fileType: fileType ?? this.fileType,
      uploadedFileUrl: uploadedFileUrl ?? this.uploadedFileUrl,
      maxFileSize: maxFileSize ?? this.maxFileSize,
    );
  }
}

const dummySurveyJson = '''
  {
    "surveyName": "Holiday Trends 2025",
    "startDate": "2025-02-07T19:26:59.159",
    "elements": [
      {
        "id": "S1",
        "type": "section",
        "title": "Section 1",
        "description": "this is discription of section 1"
      },
      {
        "id": "Q1",
        "type": "radio",
        "subtitle": null,
        "questionText": "This is single choise question ?",
        "branching": {
          "Yes": "Q2",
          "No": "Q3"
        },
        "options": ["Yes", "No"],
        "answer": null,
        "fileUpload": null,
        "csatStart": 0,
        "csatEnd": 10,
        "csatStartName": "less Likely",
        "csatEndName": "most Likely"
      },
      {
        "id": "Q2",
        "type": "text",
        "subtitle": null,
        "questionText": "This is short text if yes is selected?",
        "branching": null,
        "options": null,
        "answer": null,
        "fileUpload": null,
        "csatStart": 0,
        "csatEnd": 10,
        "csatStartName": "less Likely",
        "csatEndName": "most Likely"
      },
      {
        "id": "Q3",
        "type": "text",
        "subtitle": null,
        "questionText": "This is short text if no is selected?",
        "branching": null,
        "options": null,
        "answer": null,
        "fileUpload": null,
        "csatStart": 0,
        "csatEnd": 10,
        "csatStartName": "less Likely",
        "csatEndName": "most Likely"
      },
      {
        "id": "Q4",
        "type": "checkbox",
        "subtitle": null,
        "questionText": "This is multiple choise ",
        "branching": null,
        "options": ["Option 1", "Option 2", "Option 3"],
        "answer": null,
        "fileUpload": null,
        "csatStart": 0,
        "csatEnd": 10,
        "csatStartName": "less Likely",
        "csatEndName": "most Likely"
      },
      {
        "id": "Q5",
        "type": "textarea",
        "subtitle": null,
        "questionText": "this is long text",
        "branching": null,
        "options": null,
        "answer": null,
        "fileUpload": null,
        "csatStart": 0,
        "csatEnd": 10,
        "csatStartName": "less Likely",
        "csatEndName": "most Likely"
      },
      {
        "id": "Q6",
        "type": "integer",
        "subtitle": null,
        "questionText": "this is int ",
        "branching": null,
        "options": null,
        "answer": null,
        "fileUpload": null,
        "csatStart": 0,
        "csatEnd": 10,
        "csatStartName": "less Likely",
        "csatEndName": "most Likely"
      },
      {
        "id": "Q7",
        "type": "video",
        "subtitle": null,
        "questionText": "this is video 1",
        "branching": null,
        "options": null,
        "answer": null,
        "fileUpload": null,
        "csatStart": 0,
        "csatEnd": 10,
        "csatStartName": "less Likely",
        "csatEndName": "most Likely"
      },
      
      {
        "id": "Q9",
        "type": "image",
        "subtitle": null,
        "questionText": "this is image",
        "branching": null,
        "options": null,
        "answer": null,
        "fileUpload": null,
        "csatStart": 0,
        "csatEnd": 10,
        "csatStartName": "less Likely",
        "csatEndName": "most Likely"
      },
      {
        "id": "Q10",
        "type": "nps",
        "subtitle": null,
        "questionText": "this is nps",
        "branching": {},
        "options": null,
        "answer": null,
        "fileUpload": null,
        "csatStart": 0,
        "csatEnd": 10,
        "csatStartName": "less Likely",
        "csatEndName": "most Likely"
      },
      {
        "id": "Q11",
        "type": "csat",
        "subtitle": null,
        "questionText": "this is csat",
        "branching": null,
        "options": null,
        "answer": null,
        "fileUpload": null,
        "csatStart": 1,
        "csatEnd": 7,
        "csatStartName": "less Likely",
        "csatEndName": "most Likely"
      },
      {
        "id": "S2",
        "type": "section",
        "title": "section 2",
        "description": "This section will gather some basic details from you"
      },
      {
        "id": "Q12",
        "type": "checkbox",
        "subtitle": null,
        "questionText": "",
        "branching": null,
        "options": ["Option 1", "Option 2"],
        "answer": null,
        "fileUpload": null,
        "csatStart": 0,
        "csatEnd": 10,
        "csatStartName": "less Likely",
        "csatEndName": "most Likely"
      }
    ]
  }
  ''';
