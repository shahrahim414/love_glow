import 'package:flutter/material.dart';

class GlowBar extends StatelessWidget {
  final double value; // expects 0.0 - 1.0

  const GlowBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    double safeValue = value.clamp(0.0, 1.0); // ensure 0.0 - 1.0

    return Column(
      children: [
        Text(
          "${(safeValue * 100).toInt()}%", // display 0-100%
          style: const TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: safeValue,
            minHeight: 14,
            backgroundColor: Colors.white24,
            valueColor:
            const AlwaysStoppedAnimation(Colors.pinkAccent),
          ),
        ),
      ],
    );
  }
}
