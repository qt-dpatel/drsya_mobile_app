import 'package:drsya_mobile_app/profile/support_and_feedback/contact_support.dart';
import 'package:drsya_mobile_app/profile/support_and_feedback/help_center.dart';
import 'package:drsya_mobile_app/profile/support_and_feedback/provide_feedback.dart';
import 'package:drsya_mobile_app/profile/support_and_feedback/report_issue.dart';
import 'package:flutter/material.dart';

class SupportFeedbackScreen extends StatelessWidget {
  const SupportFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> supportOptions = [
      {
        "title": "Help Center / FAQs",
        "icon": Icons.help_outline,
      },
      {"title": "Report an Issue", "icon": Icons.report_outlined},
      {"title": "Contact Support", "icon": Icons.headset_mic_outlined},
      {"title": "Provide Feedback", "icon": Icons.feedback_outlined},
      {
        "title": "Terms of Service & Privacy Policy",
        "icon": Icons.article_outlined
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Support & Feedback"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: supportOptions.map((option) {
            return GestureDetector(
              onTap: () {
                if (option["title"] == "Help Center / FAQs") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpCenterScreen(),
                    ),
                  );
                } else if (option["title"] == "Contact Support") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactSupportScreen(),
                    ),
                  );
                } else if (option["title"] == "Provide Feedback") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProvideFeedbackScreen(),
                    ),
                  );
                } else if (option["title"] == "Report an Issue") {
                  // Add report issue functionality
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReportIssueScreen(),
                    ),
                  );
                } else if (option["title"] ==
                    "Terms of Service & Privacy Policy") {
                  // Add terms of service and privacy policy functionality
                }
              },
              child: Card(
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: ListTile(
                  leading: Icon(option["icon"], color: Colors.black54),
                  title: Text(option["title"],
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
