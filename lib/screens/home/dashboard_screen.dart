import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';
import 'home_screen.dart';
import 'pages/cutoff_screen.dart';
import 'pages/video_meeting_screen.dart';
import 'pages/colleges_screen.dart';
import 'pages/blogs_screen.dart';
import 'pages/counselling_screen.dart';
import 'pages/notifications_screen.dart';
import 'pages/mentorship_screen.dart';
import 'pages/entrance_exams_screen.dart';
import 'pages/study_abroad_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const CutoffScreen(),
    const VideoMeetingScreen(),
    const CollegesScreen(),
    const BlogsScreen(),
    const CounsellingScreen(),
    const NotificationsScreen(),
    const MentorshipScreen(),
    const EntranceExamsScreen(),
    const StudyAbroadScreen(),
    const HomeScreen(),
  ];

  final List<Map<String, dynamic>> _drawerItems = [
    {"icon": Icons.trending_up, "label": "Cutoff"},
    {"icon": Icons.video_call, "label": "Meetings"},
    {"icon": Icons.school, "label": "Colleges"},
    {"icon": Icons.article, "label": "Blogs"},
    {"icon": Icons.support_agent, "label": "Counselling"},
    {"icon": Icons.notifications, "label": "Notifications"},
    {"icon": Icons.psychology, "label": "Mentorship"},
    {"icon": Icons.quiz, "label": "Exams"},
    {"icon": Icons.flight, "label": "Abroad"},
    {"icon": Icons.person, "label": "Profile"},
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onDrawerTap(int index) {
    setState(() => _currentIndex = index);
    Navigator.pop(context); // close drawer
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user;

    return Scaffold(
      key: _scaffoldKey,

      // TOP APP BAR
      appBar: AppBar(
        title: Text(
          _drawerItems[_currentIndex]["label"],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: BodmasColors.primaryColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.logout),
        //     onPressed: () {
        //       authProvider.logout();
        //       context.go('/login');
        //     },
        //   ),
        // ],
      ),

      // MAIN BODY
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      // LEFT DRAWER ONLY
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    BodmasColors.primaryColor,
                    BodmasColors.secondaryColor,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white24,
                    child: Text(
                      user?.name.isNotEmpty == true
                          ? user!.name[0].toUpperCase()
                          : "U",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user?.name ?? "Welcome",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    user?.email ?? "",
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Drawer Menu Items
            ...List.generate(
              _drawerItems.length,
              (index) {
                return ListTile(
                  leading: Icon(
                    _drawerItems[index]["icon"],
                    color: BodmasColors.primaryColor,
                  ),
                  title: Text(_drawerItems[index]["label"]),
                  selected: index == _currentIndex,
                  selectedTileColor:
                      BodmasColors.primaryColor.withOpacity(0.1),
                  onTap: () => _onDrawerTap(index),
                );
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                authProvider.logout();
                context.go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
