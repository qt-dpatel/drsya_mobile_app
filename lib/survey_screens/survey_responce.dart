import 'package:drsya_mobile_app/common_widgets/file_upload.dart';
import 'package:drsya_mobile_app/common_widgets/stack_card_widget.dart';
import 'package:drsya_mobile_app/survey_screens/congratulation_page.dart';
import 'package:drsya_mobile_app/survey_screens/data/survey_responce_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

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
      resizeToAvoidBottomInset: false,
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
                child: SizedBox(
                  width: 328,
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
    return StackedCardWidget(
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Card(
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
                        spacing: 5.0, // Horizontal space between chips
                        runSpacing: 6.0, // Vertical space between rows
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
                                color: userResponses[question.id] == index
                                    ? Color.fromRGBO(254, 221, 190,
                                        1) // Selected background color
                                    : Color.fromRGBO(252, 244, 237,
                                        1), // Default background color
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: userResponses[question.id] == index
                                      ? Color.fromRGBO(243, 111, 52,
                                          1) // Selected border color
                                      : Colors.grey
                                          .shade300, // Default border color
                                  width: 1.0,
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      index.toString(),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color.fromRGBO(
                                            243, 111, 52, 1), // Text color
                                      ),
                                    ),
                                    if (index ==
                                        0) // Add "Not likely" inside the first chip
                                      Text(
                                        'Not likely',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Color.fromRGBO(
                                              243, 111, 52, 1), // Text color
                                        ),
                                      ),
                                    if (index ==
                                        10) // Add "Most likely" inside the last chip
                                      Text(
                                        'Most likely',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Color.fromRGBO(
                                              243, 111, 52, 1), // Text color
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),

                if (question.type == 'csat')
                  Column(
                    children: [
                      Wrap(
                        spacing: 5.0, // Horizontal space between chips
                        runSpacing: 6.0, // Vertical space between rows
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
                                color: userResponses[question.id] == index
                                    ? Color.fromRGBO(254, 221, 190,
                                        1) // Selected background color
                                    : Color.fromRGBO(252, 244, 237,
                                        1), // Default background color
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: userResponses[question.id] == index
                                      ? Color.fromRGBO(243, 111, 52,
                                          1) // Selected border color
                                      : Colors.grey
                                          .shade300, // Default border color
                                  width: 1.0,
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      index.toString(),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color.fromRGBO(
                                            243, 111, 52, 1), // Text color
                                      ),
                                    ),
                                    if (index ==
                                        0) // Add start label inside the first chip
                                      Text(
                                        question.csatStartName,
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Color.fromRGBO(
                                              243, 111, 52, 1), // Text color
                                        ),
                                      ),
                                    if (index ==
                                        question
                                            .csatEnd) // Add end label inside the last chip
                                      Text(
                                        question.csatEndName,
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Color.fromRGBO(
                                              243, 111, 52, 1), // Text color
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                // Question Input

                if (question.type == 'radio' && question.options != null)
                  Column(
                    children: question.options!.map((option) {
                      return GestureDetector(
                        onTap: () {
                          _onAnswerChanged(question.id, option);
                          setState(() {}); // Update UI to reflect selection
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: userResponses[question.id] == option
                                ? Color.fromRGBO(252, 244, 237,
                                    1) // Selected background color
                                : Colors.white, // Default background color
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: userResponses[question.id] == option
                                  ? Color.fromRGBO(
                                      243, 111, 52, 1) // Selected border color
                                  : Color.fromRGBO(
                                      134, 136, 138, 1), // Default border color
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,

                                  color: userResponses[question.id] == option
                                      ? Color.fromRGBO(243, 111, 52,
                                          1) // Selected circle color
                                      : Color.fromRGBO(134, 136, 138,
                                          1), // Default circle color
                                ),
                                child: userResponses[question.id] == option
                                    ? Icon(
                                        Icons.check,
                                        size: 18,
                                        color: Colors.white, // Tick color
                                      )
                                    : Icon(
                                        Icons.circle,
                                        size: 24,
                                        color: Colors.white, // Tick color
                                      ), // Hide tick if not selected
                              ),
                              SizedBox(width: 12.0),
                              Text(
                                option,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black, // Text color
                                ),
                              ),
                            ],
                          ),
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
                        border:
                            InputBorder.none, // Remove default underline border
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
                      return GestureDetector(
                        onTap: () {
                          List<String> selectedOptions =
                              List.from(userResponses[question.id] ?? []);
                          if (selectedOptions.contains(option)) {
                            selectedOptions.remove(option);
                          } else {
                            selectedOptions.add(option);
                          }
                          _onAnswerChanged(question.id, selectedOptions);
                          setState(() {}); // Update UI to reflect selection
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: (userResponses[question.id] as List?)
                                        ?.contains(option) ??
                                    false
                                ? Color.fromRGBO(252, 244, 237,
                                    1) // Selected background color
                                : Colors.white, // Default background color
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: (userResponses[question.id] as List?)
                                          ?.contains(option) ??
                                      false
                                  ? Color.fromRGBO(
                                      243, 111, 52, 1) // Selected border color
                                  : Colors
                                      .grey.shade300, // Default border color
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                (userResponses[question.id] as List?)
                                            ?.contains(option) ??
                                        false
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                size: 16.0,
                                color: (userResponses[question.id] as List?)
                                            ?.contains(option) ??
                                        false
                                    ? Color.fromRGBO(
                                        243, 111, 52, 1) // Selected icon color
                                    : Colors
                                        .grey.shade300, // Default icon color
                              ),
                              SizedBox(width: 12.0),
                              Text(
                                option,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black, // Text color
                                ),
                              ),
                            ],
                          ),
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
                  onPressed:
                      userResponses.containsKey(sections[_currentIndex].id)
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
        ),
      ),
    );
  }
}
