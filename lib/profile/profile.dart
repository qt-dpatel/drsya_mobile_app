import 'package:drsya_mobile_app/profile/account_settings/account_setting.dart';
import 'package:drsya_mobile_app/profile/app_preferences/app_preferences.dart';
import 'package:drsya_mobile_app/profile/profile_card.dart';
import 'package:drsya_mobile_app/profile/support_and_feedback/support_feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            children: [
              // Wrap in a Container to ensure full width
              Stack(
                clipBehavior: Clip.none, // Allows avatar to overflow
                alignment: Alignment.center,
                children: [
                  // Background Container to ensure full width
                  SizedBox(
                    width: double.infinity, // Ensures full width
                    height: 180, // Adjust based on design
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(32),
                      ),
                      child: SvgPicture.asset(
                        'assets/drysa_background.svg', // Replace with actual asset
                        fit: BoxFit
                            .cover, // Ensures it covers the entire container
                        width: double.infinity, // Ensures full width
                      ),
                    ),
                  ),

                  // Profile Title & Edit Icon
                  Positioned(
                    top: 50,
                    child: const Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 20,
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),

                  // Profile Image Positioned at the Bottom Center of the Background
                  Positioned(
                    bottom: -50, // Moves it down to overlap the background
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Color.fromRGBO(243, 111, 52, 1),
                          child: CircleAvatar(
                            radius: 48,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 48,
                            ), // Replace with actual image
                          ),
                        ),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Color.fromRGBO(243, 111, 52, 1),
                            child: Icon(Icons.camera_alt_outlined,
                                color: Colors.white, size: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 60), // Adjusted spacing

              // Profile Info
              const Text(
                "Jane Doe",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                "hellojanedoe@email.com",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // Settings List
              _buildSettingsTile(context, Icons.settings, "Account Settings"),
              _buildSettingsTile(
                  context, Icons.settings_applications, "App Preferences"),
              _buildSettingsTile(context, Icons.feedback, "Support & Feedback"),

              // Log Out Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.grey,
                      size: 18,
                    ),
                    Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // App Version & Branding
              const Spacer(),
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/drysa_darklogo.svg', // Replace with actual logo
                    height: 16,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Drsya Consumer App",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  const Text(
                    "ver 0.0.3.6 Beta",
                    style: TextStyle(fontSize: 8, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(BuildContext context, IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ProfileCard(
        icon: icon,
        title: title,
        onTap: () {
          if (title == "App Preferences") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AppPreferencesScreen()),
            );
          } else if (title == "Account Settings") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AccountSettingsScreen()),
            );
          } else if (title == "Support & Feedback") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SupportFeedbackScreen()),
            );
          }
        },
      ),
    );
  }
}
