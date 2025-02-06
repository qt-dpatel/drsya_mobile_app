import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": FeatherIcons.edit,
        "label": "Customer Feedback",
        "color": Color.fromRGBO(255, 229, 217, 1)
      },
      {
        "icon": FeatherIcons.barChart2,
        "label": "Market Research",
        "color": Color.fromRGBO(216, 232, 255, 1)
      },
      {
        "icon": FeatherIcons.activity,
        "label": "Health & Wellness",
        "color": Color.fromRGBO(233, 249, 226, 1)
      },
      {
        "icon": FeatherIcons.monitor,
        "label": "Technology & Gadgets",
        "color": Color.fromRGBO(231, 229, 255, 1)
      },
      {
        "icon": FeatherIcons.airplay,
        "label": "Travel & Tourism",
        "color": Color.fromRGBO(255, 245, 212, 1)
      },
      {
        "icon": FeatherIcons.film,
        "label": "Entertainment & Media",
        "color": Color.fromRGBO(255, 230, 247, 1)
      },
      {
        "icon": FeatherIcons.users,
        "label": "Social & Lifestyle",
        "color": Color.fromRGBO(223, 242, 255, 1)
      },
      {
        "icon": FeatherIcons.bookOpen,
        "label": "Education & Learning",
        "color": Color.fromRGBO(255, 248, 225, 1)
      },
    ];

    // Split categories into two rows
    List<Map<String, dynamic>> firstRow = categories.sublist(0, 4);
    List<Map<String, dynamic>> secondRow = categories.sublist(4, 8);

    Widget buildCategory(Map<String, dynamic> category) {
      return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: category["color"],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(category["icon"], color: Colors.black, size: 24),
            ),
            const SizedBox(height: 6),
            Text(
              category["label"]!,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(231, 239, 255, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Categories",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 12),
          Row(
              children:
                  firstRow.map((category) => buildCategory(category)).toList()),
          const SizedBox(height: 16),
          Row(
              children: secondRow
                  .map((category) => buildCategory(category))
                  .toList()),
        ],
      ),
    );
  }
}
