import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History 💖"),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.favorite,
                color: Colors.pinkAccent),
            title: Text("Rahim ❤️ Sara"),
            subtitle: Text("Score: ${(50 + index)}%"),
          );
        },
      ),
    );
  }
}
