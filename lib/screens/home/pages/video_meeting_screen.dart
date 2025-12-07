import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class VideoMeetingScreen extends StatelessWidget {
  const VideoMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Meeting'),
        backgroundColor: BodmasColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.video_call, size: 120, color: BodmasColors.primaryColor),
            const SizedBox(height: 24),
            const Text(
              'Join Live Counselling Sessions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Connect with expert counsellors via video call',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => _joinMeeting(context),
              icon: const Icon(Icons.meeting_room),
              label: const Text('Join Live Session'),
              style: ElevatedButton.styleFrom(
                backgroundColor: BodmasColors.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _joinMeeting(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Redirecting to video meeting...')),
    );
  }
}
