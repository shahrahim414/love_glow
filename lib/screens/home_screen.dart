import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import '../widgets/glass_textfield.dart';
import '../widgets/glow_bar.dart';
import '../widgets/animated_heart.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double loveScore = 0.0;

  void generateScore() {
    setState(() {
      // Random percentage between 20 and 100
      int percentage = 20 + (DateTime.now().second % 81); // 20-100
      loveScore = percentage / 100; // convert to 0.0 - 1.0
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("LoveGlow 💖"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF4B8B), Color(0xFF6A5AE0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AnimatedHeart(),
                const SizedBox(height: 30),
                GlowBar(value: loveScore),
                SizedBox(height: 40),
                GlassCard(
                  child: Column(
                    children: [
                      const GlassTextField(hint: "Your Name"),
                      const SizedBox(height: 20),
                      const GlassTextField(hint: "Partner Name"),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: generateScore,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 14,
                          ),
                        ),
                        child: const Text("TEST LOVE"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // GlowBar(value: loveScore),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
