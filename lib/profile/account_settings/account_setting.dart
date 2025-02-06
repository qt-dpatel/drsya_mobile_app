import 'package:drsya_mobile_app/profile/account_settings/change_password.dart';
import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account Settings",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white), // White back arrow
        backgroundColor:
            const Color.fromRGBO(5, 30, 41, 1), // Dark blue-green background
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSettingsCard(
              context,
              title: "Change Password",
              icon: Icons.key,
              backgroundColor: Colors.blue.shade50, // Light blue background
              textColor: Colors.black87,
              iconColor: Colors.black54,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen()),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildSettingsCard(
              context,
              title: "Delete Account",
              icon: Icons.delete,
              backgroundColor: Colors.red.shade50, // Light red background
              textColor: Colors.red.shade700,
              iconColor: Colors.red.shade400,
              onTap: () {
                // Add delete account functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color backgroundColor,
    required Color textColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: backgroundColor,
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 16, color: Colors.black54),
        onTap: onTap,
      ),
    );
  }
}
