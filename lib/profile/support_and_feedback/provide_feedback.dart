import 'package:flutter/material.dart';

class ProvideFeedbackScreen extends StatelessWidget {
  const ProvideFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Provide Feedback")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your feedback helps us improve!",
                style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 20),
            const Text("Feature Requests:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Suggest new features or improvements.",
              ),
            ),
            const SizedBox(height: 20),
            const Text("Rate the App:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.star, color: Colors.yellow),
              label: const Text("Rate the app on Google Play"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[50],
                foregroundColor: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const Text("Feature Requests:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Suggest new features or improvements.",
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text("Submit Feedback"),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
                child:
                    Text("Thank you for helping us make the app better! 😊")),
          ],
        ),
      ),
    );
  }
}
