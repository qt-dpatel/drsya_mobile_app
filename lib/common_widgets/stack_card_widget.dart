import 'dart:ui';

import 'package:flutter/material.dart';

class StackedCardWidget extends StatelessWidget {
  final Widget child;
  final double width;
  final double borderRadius;

  const StackedCardWidget({
    Key? key,
    required this.child,
    this.width = 296,
    this.borderRadius = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          bottom: 5, // Position the bottom card slightly below
          child: Container(
            width: 272,
            height: 40,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        Positioned(
          bottom: 12, // Slightly above the second card
          child: Container(
            width: 292,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        // The main card
        child,
      ],
    );
  }
}
