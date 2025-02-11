import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SurveyDetailsPage extends StatelessWidget {
  const SurveyDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SurveyDetailsMobile(),
    );
  }
}

class SurveyDetailsMobile extends StatelessWidget {
  const SurveyDetailsMobile({super.key});

  void _showLanguageSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return const LanguageSelectionModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom App Bar with SVG
        Container(
          width: 360,
          height: 276,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SvgPicture.asset(
                'assets/drysa_background.svg',
                width: 360,
                height: 276,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40,
                left: 16,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      "Survey Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 50,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Dec 16, 2024 - Feb 25, 2025",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildChipset(),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Survey Information
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Holiday Trends 2025",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "Discover travel trends shaping 2025! Join the survey and share your insights.",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),

        const Spacer(),

        // Start Survey Button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _showLanguageSelection(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Start Survey",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChipset() {
    return Row(
      children: [
        _infoBadge("2 Sections"),
        _infoBadge("10 Questions"),
        _infoBadge("13m Avg Time"),
      ],
    );
  }

  Widget _infoBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class LanguageSelectionModal extends StatefulWidget {
  const LanguageSelectionModal({super.key});

  @override
  _LanguageSelectionModalState createState() => _LanguageSelectionModalState();
}

class _LanguageSelectionModalState extends State<LanguageSelectionModal> {
  String? selectedLanguage;

  final List<Map<String, String>> languages = [
    {"label": "English", "code": "en"},
    {"label": "বাংলা (Bengali)", "code": "bn"},
    {"label": "हिंदी (Hindi)", "code": "hi"},
    {"label": "ગુજરાતી (Gujarati)", "code": "gu"},
    {"label": "ಕನ್ನಡ (Kannada)", "code": "kn"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Choose Your Survey Language",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...languages.map((lang) {
            return ListTile(
              title: Text(lang["label"]!),
              trailing: selectedLanguage == lang["code"]
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                setState(() {
                  selectedLanguage = lang["code"];
                });
              },
            );
          }).toList(),
          const Spacer(),
          ElevatedButton(
            onPressed: selectedLanguage != null ? () {} : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  selectedLanguage != null ? Colors.blue : Colors.grey[300],
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              "Continue",
              style: TextStyle(
                  color: selectedLanguage != null
                      ? Colors.white
                      : Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
