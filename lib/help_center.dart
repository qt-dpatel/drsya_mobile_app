import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> faqs = [
      {
        "question": "How do I participate in surveys?",
        "answer":
            "You can find available surveys in the 'My Surveys' section. Tap a survey to start answering.",
      },
      {
        "question": "How do I track my survey responses?",
        "answer":
            "You can view submitted responses under the 'Responses' tab in your dashboard.",
      },
      {
        "question": "Can I edit my responses after submission?",
        "answer": "No, once submitted, responses cannot be modified.",
      },
      {
        "question": "How do I manage my notification settings?",
        "answer":
            "Go to 'Settings' and navigate to 'Notifications' to enable or disable alerts.",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Help Center / FAQs"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Find answers to common questions about using the app.",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),
            const Text(
              "Popular Questions:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: faqs.map((faq) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ExpansionTile(
                      leading: const Icon(Icons.circle,
                          size: 10, color: Colors.orange),
                      title: Text(faq["question"]!,
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(faq["answer"]!,
                              style: const TextStyle(color: Colors.black54)),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            const Text("More Questions?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.headset_mic_outlined,
                    color: Colors.black54),
                title: const Text("Contact Support",
                    style: TextStyle(fontWeight: FontWeight.w500)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {
                  // Add support action
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
