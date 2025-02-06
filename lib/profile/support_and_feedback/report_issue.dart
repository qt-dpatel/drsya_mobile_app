import 'package:flutter/material.dart';

class ReportIssueScreen extends StatelessWidget {
  const ReportIssueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Report an Issue")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Facing a problem? Let us know, and we'll fix it ASAP!",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 15),
            const Text("Describe the issue:"),
            const SizedBox(height: 5),
            const TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Please describe the issue you are facing.",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const Text("Attach a Screenshot (Optional):"),
            const SizedBox(height: 5),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload),
              label: const Text("Upload"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[50],
                foregroundColor: Colors.blue,
              ),
            ),
            const SizedBox(height: 15),
            const Text("Where did this happen?"),
            const SizedBox(height: 5),
            DropdownButtonFormField(
              items: const [
                DropdownMenuItem(child: Text("Home Screen"), value: "home"),
                DropdownMenuItem(child: Text("Survey Page"), value: "survey"),
                DropdownMenuItem(child: Text("Settings"), value: "settings"),
              ],
              onChanged: (value) {},
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Select",
              ),
            ),
            const SizedBox(height: 15),
            const Text("Your Email (for follow-up):"),
            const SizedBox(height: 5),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Email",
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text("Submit Report"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
