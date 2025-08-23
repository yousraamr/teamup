import 'package:flutter/material.dart';
import '../../../../constants.dart';

class TeamPreview extends StatelessWidget {
  final String teamName;
  final String initial;

  const TeamPreview({
    super.key,
    required this.teamName,
    required this.initial,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: primary,
            child: Text(initial, style: body.copyWith(color: Colors.white)),
          ),
          const SizedBox(width: 15),
          Text(
            teamName,
            style: body.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text("View Team"),
          ),
        ],
      ),
    );
  }
}
