import 'package:drsya_mobile_app/categories.dart';
import 'package:drsya_mobile_app/new_servey.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          NewSurveys(),
          SizedBox(height: 20),
          Categories(),
        ],
      ),
    );
  }
}
