import 'package:flutter/material.dart';

class AnimatedHeart extends StatefulWidget {
  const AnimatedHeart({super.key});

  @override
  State<AnimatedHeart> createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<AnimatedHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      lowerBound: 0.8,
      upperBound: 1.2,
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _controller,
      child: const Icon(
        Icons.favorite,
        color: Colors.pinkAccent,
        size: 80,
      ),
    );
  }
}
