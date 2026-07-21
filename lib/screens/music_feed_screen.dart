import 'package:flutter/material.dart';

class MusicFeedScreen extends StatelessWidget {
  const MusicFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('মিউজিক ফিড', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 10, // এখানে আপনার ডাটাবেস থেকে পাওয়া গানের সংখ্যা হবে
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.music_note, color: Colors.deepPurple),
              ),
              title: Text('গান শিরোনাম ${index + 1}'),
              subtitle: const Text('শিল্পী: নাম এখানে'),
              trailing: const Icon(Icons.play_circle_fill, color: Colors.deepPurple, size: 32),
              onTap: () {
                // এখানে গান প্লে করার লজিক আসবে
              },
            ),
          );
        },
      ),
    );
  }
}

