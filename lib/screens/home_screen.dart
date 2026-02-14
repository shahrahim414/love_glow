import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
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

  final TextEditingController _yourNameController = TextEditingController();
  final TextEditingController _partnerNameController = TextEditingController();

  final DatabaseReference _dbRef =
  FirebaseDatabase.instance.ref().child("love_scores");

  void generateScoreAndSave() async {
    String yourName = _yourNameController.text.trim();
    String partnerName = _partnerNameController.text.trim();

    if (yourName.isEmpty || partnerName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both names")),
      );
      return;
    }

    setState(() {
      int percentage = 20 + (DateTime.now().second % 81); // 20-100
      loveScore = percentage / 100;
    });

    try {
      String key = _dbRef.push().key!;
      await _dbRef.child(key).set({
        "your_name": yourName,
        "partner_name": partnerName,
        "score": (loveScore * 100).toInt(),
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Saved to Firebase!")),
      );

      _yourNameController.clear();
      _partnerNameController.clear();

      fetchAndPrintScores();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving: $e")),
      );
    }
  }

  void fetchAndPrintScores() async {
    try {
      final snapshot = await _dbRef.get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        print("All scores in Firebase:");
        data.forEach((key, value) {
          print(
              "Your Name: ${value['your_name']}, Partner Name: ${value['partner_name']}, Score: ${value['score']}%, Time: ${DateTime.fromMillisecondsSinceEpoch(value['timestamp'])}");
        });
      } else {
        print("No scores found in Firebase yet.");
      }
    } catch (e) {
      print("Error reading data: $e");
    }
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
                const SizedBox(height: 40),
                GlassCard(
                  child: Column(
                    children: [
                      GlassTextField(
                        controller: _yourNameController,
                        hint: "Your Name",
                      ),
                      const SizedBox(height: 20),
                      GlassTextField(
                        controller: _partnerNameController,
                        hint: "Partner Name",
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: generateScoreAndSave,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 14),
                        ),
                        child: const Text("TEST LOVE"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
