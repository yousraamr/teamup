import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/task_card.dart';
import '../widgets/team_preview.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: Text("Hello, Yousra 👋", style: h2),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: primary),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          children: [
            // Quick Stats
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: const [
                  DashboardCard(title: "My Tasks", count: 12, icon: Icons.task),
                  SizedBox(width: 15),
                  DashboardCard(title: "Completed", count: 8, icon: Icons.check),
                  SizedBox(width: 15),
                  DashboardCard(title: "Pending", count: 4, icon: Icons.schedule),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // My Tasks Section
            Text("My Tasks", style: h2),
            const SizedBox(height: 10),
            Column(
              children: const [
                TaskCard(title: "Design Homepage", status: "In Progress", dueDate: "Aug 25"),
                TaskCard(title: "Prepare Presentation", status: "Pending", dueDate: "Aug 24"),
                TaskCard(title: "Fix Bugs", status: "Completed", dueDate: "Aug 22"),
              ],
            ),
            const SizedBox(height: 30),

            // Team Preview
            Text("Team Preview", style: h2),
            const SizedBox(height: 10),
            const TeamPreview(teamName: "Marketing Team", initial: "M"),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}