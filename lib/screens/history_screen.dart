import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference scoresCollection =
    FirebaseFirestore.instance.collection('love_scores');

    return Scaffold(
      appBar: AppBar(
        title: const Text("History 💖"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF4B8B), Color(0xFF6A5AE0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: scoresCollection.orderBy('timestamp', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "No love scores yet!",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
            }

            final docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;

                final yourName = data['your_name'] ?? "Unknown";
                final partnerName = data['partner_name'] ?? "Unknown";
                final score = data['score'] ?? 0;

                return ListTile(
                  leading: const Icon(
                    Icons.favorite,
                    color: Colors.pinkAccent,
                  ),
                  title: Text(
                    "$yourName ❤️ $partnerName",
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "Score: $score%",
                    style: const TextStyle(color: Colors.white70),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
