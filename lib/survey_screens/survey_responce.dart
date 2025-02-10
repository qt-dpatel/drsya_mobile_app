import 'package:drsya_mobile_app/common_widgets/file_upload.dart';
import 'package:drsya_mobile_app/survey_screens/congratulation_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

final Map<String, TextEditingController> textControllers = {};
final Map<String, dynamic> userResponses = {};
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

class UserResponcePage extends StatefulWidget {
  const UserResponcePage({super.key});

  @override
  State<UserResponcePage> createState() => _UserResponcePageState();
}

class _UserResponcePageState extends State<UserResponcePage> {
  final List<dynamic> sections = [];
  int _currentIndex = 0;
  String? surveyName;
  String? startDate;

  @override
  void initState() {
    super.initState();
    _loadSurveyFromLocal();
  }

  Future<void> _loadSurveyFromLocal() async {
    // Dummy JSON data

    try {
      // Parse the dummy JSON
      final parsedData = jsonDecode(dummySurveyJson);
      final elements = parsedData['elements'] as List;
      surveyName = parsedData['surveyName'];
      startDate = parsedData['startDate'];

      setState(() {
        sections.clear();
        for (var element in elements) {
          if (element['type'] == 'section') {
            sections.add(Section.fromJson(element));
          } else {
            sections.add(Question.fromJson(element));
          }
        }
      });
    } catch (e) {
      debugPrint("Error parsing survey data: $e");
      setState(() {
        sections.clear();
      });
    }
  }

  void _onAnswerChanged(String questionId, dynamic answer) {
    setState(() {
      userResponses[questionId] = answer;
    });
  }

  void _navigateToNextQuestion() {
    final currentQuestion = sections[_currentIndex] as Question;
    dynamic selectedAnswer = userResponses[currentQuestion.id];

    if (currentQuestion.branching != null &&
        currentQuestion.branching!.isNotEmpty) {
      String? nextQuestionId = currentQuestion.branching?[selectedAnswer];

      if (nextQuestionId != null) {
        int nextIndex =
            sections.indexWhere((element) => element.id == nextQuestionId);
        if (nextIndex != -1) {
          setState(() {
            _currentIndex = nextIndex;
          });
          return;
        }
      }
    }

    // If it's the last question, navigate to the Congrats screen
    if (_currentIndex == sections.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CongratulationsPage()),
      );
    } else {
      // Proceed sequentially if not last question
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _nextQuestion() {
    if (_currentIndex < sections.length - 1) {
      // Clear controllers (if needed)
      textControllers.clear();
      setState(() {
        _currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentSection = sections[_currentIndex];

    return Scaffold(
      backgroundColor: Color.fromRGBO(5, 30, 41, 1), // Background color
      body: SafeArea(
        child: Column(
          spacing: 16,
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              surveyName ?? 'Survey Name',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            // Question Indicator
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                children: [
                  currentSection is Section
                      ? Text(
                          currentSection.title ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "${_currentIndex} of ${sections.length}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                  Spacer(),
                  // Three dots
                  Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            // Progress Indicator
            Container(
              height: 4,
              margin: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: LinearProgressIndicator(
                value: (_currentIndex + 1) / sections.length,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF36F34)),
              ),
            ),
            // Main Card
            Expanded(
              child: Center(
                child: Container(
                  width: 328,
                  height: 612,
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: _buildCard(currentSection),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(dynamic section) {
    if (section is Section) {
      return _buildSectionCard(section);
    } else if (section is Question) {
      return _buildQuestionCard(section);
    }
    return Container();
  }

  Widget _buildSectionCard(Section section) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.white, // White card color
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section.title ?? '',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),

            Spacer(),
            // Section title
            Text(
              section.title ?? '',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 6),
            Text(
              '9 questions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 6),
            // Section description
            Text(
              section.description!,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            Spacer(),
            // Big Next Button
            ElevatedButton(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF36F34),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Next", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(Question question) {
    if (question.type == 'text' ||
        question.type == 'textarea' ||
        question.type == 'integer') {
      textControllers.putIfAbsent(question.id, () => TextEditingController());
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.white, // White card color
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select an answer',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            // Question Text
            Text(
              question.questionText,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.black), // Black text
            ),
            SizedBox(height: 16),
            if (question.type == 'nps')
              Column(
                children: [
                  Wrap(
                    spacing: 8.0, // Horizontal space between chips
                    runSpacing: 8.0, // Vertical space between rows
                    children: List.generate(11, (index) {
                      return GestureDetector(
                        onTap: () {
                          _onAnswerChanged(question.id, index);
                          setState(() {}); // Update UI to reflect selection
                        },
                        child: Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(25, 22, 29, 0.06),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: userResponses[question.id] == index
                                  ? Colors
                                      .black // Darker border for selected chip
                                  : Colors
                                      .grey.shade300, // Default border color
                              width: 1.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              index.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Color.fromRGBO(134, 136, 138, 1),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16.0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Not likely',
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Color.fromRGBO(134, 136, 138, 1)),
                      ),
                      Text(
                        'Most likely',
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Color.fromRGBO(134, 136, 138, 1)),
                      ),
                    ],
                  ),
                ],
              ),

            if (question.type == 'csat')
              Column(
                children: [
                  Wrap(
                    spacing: 8.0, // Horizontal space between chips
                    runSpacing: 8.0, // Vertical space between rows
                    children: List.generate(question.csatEnd + 1, (index) {
                      return GestureDetector(
                        onTap: () {
                          _onAnswerChanged(question.id, index);
                          setState(() {}); // Update UI to reflect selection
                        },
                        child: Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(25, 22, 29, 0.06),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: userResponses[question.id] == index
                                  ? Colors
                                      .black // Darker border for selected chip
                                  : Colors
                                      .grey.shade300, // Default border color
                              width: 1.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              index.toString(),
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Color.fromRGBO(134, 136, 138, 1)),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        question.csatStartName,
                        style: const TextStyle(
                            fontSize: 12.0,
                            color: Color.fromRGBO(134, 136, 138, 1)),
                      ),
                      Text(
                        question.csatEndName,
                        style: const TextStyle(
                            fontSize: 12.0,
                            color: Color.fromRGBO(134, 136, 138, 1)),
                      ),
                    ],
                  ),
                ],
              ),
            // Question Input
            if (question.type == 'radio' && question.options != null)
              Column(
                children: question.options!.map((option) {
                  return ListTile(
                    title: Text(option),
                    leading: Radio(
                      value: option,
                      groupValue: userResponses[question.id],
                      onChanged: (value) {
                        _onAnswerChanged(question.id, value);
                      },
                    ),
                  );
                }).toList(),
              ),
            if (question.type == 'text' ||
                question.type == 'textarea' ||
                question.type == 'integer')
              Container(
                width: double.infinity,
                height: question.type == 'textarea' ? 320 : null,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(250, 250, 250, 1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: TextField(
                  controller: textControllers[question.id],
                  onChanged: (value) {
                    _onAnswerChanged(question.id, value);
                  },
                  keyboardType: question.type == 'integer'
                      ? TextInputType.number
                      : TextInputType.text,
                  inputFormatters: question.type == 'integer'
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : null,
                  decoration: InputDecoration(
                    hintText: question.type == 'integer'
                        ? 'Enter Answer in Numbers'
                        : 'Enter Answer',
                    border: InputBorder.none, // Remove default underline border
                  ),
                  maxLines: question.type == 'textarea' ? 16 : 1,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black54,
                      ),
                ),
              ),

            if (question.type == 'checkbox' && question.options != null)
              Column(
                children: question.options!.map((option) {
                  return ListTile(
                    title: Text(option),
                    leading: Checkbox(
                      value: (userResponses[question.id] as List?)
                              ?.contains(option) ??
                          false,
                      onChanged: (value) {
                        List<String> selectedOptions =
                            List.from(userResponses[question.id] ?? []);
                        if (value == true) {
                          selectedOptions.add(option);
                        } else {
                          selectedOptions.remove(option);
                        }
                        _onAnswerChanged(question.id, selectedOptions);
                      },
                    ),
                  );
                }).toList(),
              ),

            if (question.type == 'audio' ||
                question.type == 'video' ||
                question.type == 'image')
              FileUploadWidget(
                type: question.type,
                maxFileSize: 10.0,
                onFileUploaded: (fileUpload) {
                  // Handle the uploaded file
                  _onAnswerChanged(question.id, "");
                },
              ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     ElevatedButton.icon(
            //       onPressed: () {},
            //       icon: const Icon(Icons.upload),
            //       label: Text(
            //           "Upload ${question.type[0].toUpperCase() + question.type.substring(1)} File"),
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.white,
            //         foregroundColor: Colors.black,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20.0),
            //         ),
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 16.0, vertical: 12.0),
            //       ),
            //     ),
            //     Text(
            //       "Max file size : ${question.fileUpload?.maxFileSize ?? 'Not Set'}", // Show max file size or 'Not Set' if not provided
            //       style: const TextStyle(fontSize: 14.0),
            //     ),
            //   ],
            // ),

            Spacer(),
            // Navigation Buttons
            ElevatedButton(
              onPressed: userResponses.containsKey(sections[_currentIndex].id)
                  ? () => _navigateToNextQuestion()
                  : null, // Disable if no answer
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    userResponses.containsKey(sections[_currentIndex].id)
                        ? Color(0xFFF36F34)
                        : Colors.grey, // Grey when disabled
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Next", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

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
