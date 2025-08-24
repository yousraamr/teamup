import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';
import '../../bloc/home_state.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/task_card.dart';
import '../widgets/team_preview.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  final String uid; // pass from login/auth
  const HomeScreen({super.key, required this.uid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeStarted(widget.uid));
  }

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: secondary,
          appBar: AppBar(
            backgroundColor: white,
            elevation: 0,
            title: Text("Hello, ${state.userName ?? 'User'} 👋", style: h2),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications, color: primary),
                onPressed: () {},
              ),
            ],
          ),
          body: state.loading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              children: [
                // Quick Stats
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      DashboardCard(
                          title: "My Tasks", count: state.tasks.length, icon: Icons.task),
                      DashboardCard(
                          title: "Completed",
                          count: state.tasks
                              .where((t) => t.status.toLowerCase() == 'completed')
                              .length,
                          icon: Icons.check),
                      DashboardCard(
                          title: "Pending",
                          count: state.tasks
                              .where((t) => t.status.toLowerCase() == 'pending')
                              .length,
                          icon: Icons.schedule),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // My Tasks Section
                Text("My Tasks", style: h2),
                const SizedBox(height: 10),
                Column(
                  children: state.tasks.map((task) {
                    return TaskCard(
                      title: task.title,
                      status: task.status,
                      dueDate: task.dueDate != null
                          ? "${task.dueDate!.day}-${task.dueDate!.month}-${task.dueDate!.year}"
                          : '',
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),

                // Team Preview
                Text("Team Preview", style: h2),
                const SizedBox(height: 10),
                Column(
                  children: state.teams.map((team) {
                    return TeamPreview(
                      teamName: team['name'] ?? 'Team',
                      initial: team['initials'] ?? '',
                    );
                  }).toList(),
                ),
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
      },
    );
  }
}
