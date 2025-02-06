import 'package:drsya_mobile_app/profile/app_preferences/notification_settings.dart';
import 'package:drsya_mobile_app/profile/profile_card.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: ProfileCard(
          icon: Icons.notifications,
          title: "Notification Settings",
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
    );
  }
}
