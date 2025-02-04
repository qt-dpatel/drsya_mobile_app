import 'package:flutter/material.dart';

class NewSurveys extends StatelessWidget {
  const NewSurveys({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> surveys = [
      {"title": "Lifestyle Insights 2024", "date": "Today"},
      {"title": "Travel Preferences Study", "date": "Today"},
      {"title": "Work Behavior Survey", "date": "Yesterday"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: const Text(
            "New Surveys",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        SizedBox(
          height: 92,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: surveys.length,
            itemBuilder: (context, index) {
              return Container(
                width: 156,
                height: 86,
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        surveys[index]["title"]!,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Text(
                      surveys[index]["date"]!,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
