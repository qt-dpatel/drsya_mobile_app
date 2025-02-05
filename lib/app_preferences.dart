import 'package:drsya_mobile_app/notification_settings.dart';
import 'package:flutter/material.dart';

class AppPreferencesScreen extends StatelessWidget {
  const AppPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "App Preferences",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(5, 30, 41, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: ListTile(
            leading: const Icon(Icons.notifications, color: Colors.black54),
            title: const Text("Notification Settings"),
            trailing: const Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.black54),
            onTap: () {
              // Navigate to Notification Settings Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationSettingsScreen()),
              );
            },
          ),
        ),
      ),
    );
  }
}
