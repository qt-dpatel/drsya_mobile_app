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
              _buildSettingsTile(Icons.settings, "Account Settings"),
              _buildSettingsTile(
                  Icons.settings_applications, "App Preferences"),
              _buildSettingsTile(Icons.feedback, "Support & Feedback"),

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

  Widget _buildSettingsTile(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: Color.fromRGBO(242, 246, 253, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        child: ListTile(
          leading: Icon(
            icon,
            color: Color.fromRGBO(5, 30, 41, 1),
            size: 24,
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          trailing: Icon(Icons.arrow_forward_ios,
              size: 16, color: Color.fromRGBO(5, 30, 41, 1)),
          onTap: () {},
        ),
      ),
    );
  }
}
