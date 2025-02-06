import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool enableAllNotifications = true;
  bool newSurveys = true;
  bool surveyDeadline = true;
  bool surveyCompletion = false;
  bool profileUpdates = true;
  bool featureUpdates = true;
  bool pushNotifications = true;
  bool emailNotifications = false;
  bool smsNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notification Settings",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(5, 30, 41, 1),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          _buildSectionHeader("General Notifications"),
          _buildSwitchTile(
              "Enable/Disable All Notifications", enableAllNotifications,
              (value) {
            setState(() => enableAllNotifications = value);
          }),
          _buildSectionHeader("Survey Notifications"),
          _buildSwitchTile("New Surveys Available", newSurveys, (value) {
            setState(() => newSurveys = value);
          }),
          _buildSwitchTile("Survey Deadline Reminders", surveyDeadline,
              (value) {
            setState(() => surveyDeadline = value);
          }),
          _buildSwitchTile("Survey Completion Confirmation", surveyCompletion,
              (value) {
            setState(() => surveyCompletion = value);
          }),
          _buildSectionHeader("Account & Activity Notifications"),
          _buildSwitchTile("Profile Updates & Security Alerts", profileUpdates,
              (value) {
            setState(() => profileUpdates = value);
          }),
          _buildSectionHeader("Important Announcements"),
          _buildSwitchTile("Feature Updates & Announcements", featureUpdates,
              (value) {
            setState(() => featureUpdates = value);
          }),
          _buildSectionHeader("Notification Channels"),
          _buildSwitchTile("Push Notifications", pushNotifications, (value) {
            setState(() => pushNotifications = value);
          }),
          _buildSwitchTile("Email Notifications", emailNotifications, (value) {
            setState(() => emailNotifications = value);
          }),
          _buildSwitchTile("SMS Notifications", smsNotifications, (value) {
            setState(() => smsNotifications = value);
          }),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(title,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  Widget _buildSwitchTile(
      String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.orange,
    );
  }
}
