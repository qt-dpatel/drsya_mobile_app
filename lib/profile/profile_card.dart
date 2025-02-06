import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color cardColor;
  final VoidCallback onTap;
  final bool isDelete;

  const ProfileCard({
    super.key,
    required this.icon,
    required this.title,
    this.cardColor = const Color.fromRGBO(242, 246, 253, 1), // Default color
    required this.onTap,
    this.isDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: !isDelete
                ? Color.fromRGBO(5, 30, 41, 1)
                : Color.fromRGBO(213, 57, 60, 1),
            size: 24,
          ),
          title: Text(title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: !isDelete
                    ? Color.fromRGBO(5, 30, 41, 1)
                    : Color.fromRGBO(213, 57, 60, 1),
              )),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: !isDelete
                ? Color.fromRGBO(5, 30, 41, 1)
                : Color.fromRGBO(213, 57, 60, 1),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
