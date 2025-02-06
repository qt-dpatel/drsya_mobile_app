import 'package:drsya_mobile_app/profile/account_settings/change_password.dart';
import 'package:drsya_mobile_app/profile/profile_card.dart';
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
      body: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          _buildSettingsCard(
            context,
            title: "Change Password",
            icon: Icons.key,
          ),
          _buildSettingsCard(
            context,
            title: "Delete Account",
            icon: Icons.delete,
            backgroundColor:
                Color.fromRGBO(252, 242, 242, 1), // Light red background
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    Color? backgroundColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ProfileCard(
        icon: icon,
        title: title,
        isDelete: (title == "Delete Account") ? true : false,
        cardColor: backgroundColor ?? const Color.fromRGBO(242, 246, 253, 1),
        onTap: () {
          if (title == "Change Password") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ChangePasswordScreen()),
            );
          } else if (title == "Delete Account") {
            // Add delete account logic here
          }
        },
      ),
    );
  }
}
