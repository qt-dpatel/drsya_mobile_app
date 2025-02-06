import 'package:flutter/material.dart';

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Support")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Get in touch with our support team.",
                style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 20),
            const Text("Call Us:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Card(
              color: Colors.green[50],
              child: ListTile(
                leading: const Icon(Icons.phone, color: Colors.green),
                title: const Text("+91 9876 54321"),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 15),
            const Text("Email Us:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Card(
              color: Colors.orange[50],
              child: ListTile(
                leading: const Icon(Icons.email, color: Colors.orange),
                title: const Text("support@drysasurveyapp.com"),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 15),
            const Text("Live Chat:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Card(
              color: Colors.blue[50],
              child: ListTile(
                leading: const Icon(Icons.chat, color: Colors.blue),
                title: const Text("Start Chat"),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 20),
            const Text("Support Hours:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const Text("Monday - Friday: 9 AM - 6 PM"),
            const Text("Saturday - Sunday: 10 AM - 4 PM"),
          ],
        ),
      ),
    );
  }
}
