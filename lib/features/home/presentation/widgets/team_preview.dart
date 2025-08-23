import 'package:flutter/material.dart';

class TeamPreviewSection extends StatelessWidget {
  final String role;

  const TeamPreviewSection({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final sampleTeam = [
      {"name": "Alice", "role": "Designer"},
      {"name": "Bob", "role": "Developer"},
      {"name": "Charlie", "role": "QA Tester"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "My Team",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sampleTeam.length,
            itemBuilder: (context, index) {
              final member = sampleTeam[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(12),
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Text(member["name"]![0]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      member["name"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      member["role"]!,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
