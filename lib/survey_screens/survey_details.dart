import 'package:drsya_mobile_app/survey_screens/survey_responce.dart';
import 'package:flutter/material.dart';

class SurveyDetailsPage extends StatelessWidget {
  const SurveyDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (Top Section with SVG Background)
                Container(
                  height: 276,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // SVG Background
                      Positioned.fill(
                        child: Image.asset(
                          'assets/drysa_blue_bg.png', // Replace with your SVG file path
                          fit: BoxFit.fill,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 16, right: 16),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back,
                                      color: Colors.black),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                const Spacer(),
                                const Text(
                                  'Survey Details',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                const SizedBox(width: 48),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Holiday Trends 2025',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Dec 16, 2024 - Feb 25, 2025',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildInfoChip('2', ' Sections'),
                                const SizedBox(width: 8),
                                _buildInfoChip('10', ' Questions'),
                                const SizedBox(width: 8),
                                _buildInfoChip('13m', ' Avg Time'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Description Section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Holiday Trends 2025 explores the evolving preferences and behaviors of travelers worldwide. '
                    'This survey gathers insights into popular destinations, travel budgets, accommodation choices, '
                    'and unique experiences shaping the future of tourism. Whether you\'re a solo adventurer, a family traveler, '
                    'or part of a group, your input will help identify key trends, from sustainable tourism and cultural immersion '
                    'to luxury escapes and adventure travel. Share your preferences and discover how others plan to spend their holidays in 2025. '
                    'Your participation contributes to a comprehensive understanding of global holiday trends and helps businesses cater better to travelers like you!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Start Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _showLanguageSelection(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(243, 111, 52, 1),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Start Survey',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageSelection(BuildContext context) {
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
              return const LanguageSelectionModal();
            });
      },
    );
  }

  // Updated Info Chip UI
  Widget _buildInfoChip(String value, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color:
              const Color.fromRGBO(245, 245, 245, 1), // Light grey background
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: Color.fromRGBO(178, 205, 255, 1)), // Subtle border
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageSelectionModal extends StatefulWidget {
  const LanguageSelectionModal({super.key});

  @override
  State<LanguageSelectionModal> createState() => _LanguageSelectionModalState();
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
                  ? const Icon(Icons.check,
                      color: Color.fromRGBO(243, 111, 52, 1))
                  : null,
              onTap: () {
                setState(() {
                  selectedLanguage = lang["code"];
                });
              },
            );
          }),
          const Spacer(),
          ElevatedButton(
            onPressed: selectedLanguage != null
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserResponcePage()),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: selectedLanguage != null
                  ? const Color.fromRGBO(243, 111, 52, 1)
                  : Colors.grey[300],
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
