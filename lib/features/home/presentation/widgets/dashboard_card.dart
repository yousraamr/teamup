import 'package:flutter/material.dart';
import '../../../../constants.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;

  const DashboardCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(10), // slightly smaller padding
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
      child: Column(
        mainAxisSize: MainAxisSize.min, // important: only take needed height
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: primary),
          const SizedBox(height: 8), // reduce spacing slightly
          Text("$count", style: h2),
          const SizedBox(height: 4),
          Flexible(
            child: Text(
              title,
              style: body,
              overflow: TextOverflow.ellipsis, // prevent text overflow
            ),
          ),
        ],
      ),
    );
  }
}