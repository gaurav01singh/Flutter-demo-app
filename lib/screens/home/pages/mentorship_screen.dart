import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class MentorshipScreen extends StatelessWidget {
  const MentorshipScreen({super.key});

  final List<Map<String, dynamic>> _mentors = const [
    {
      'name': 'Aman Singh',
      'exam': 'NEET',
      'score': 720,
      'college': 'AIIMS Delhi',
      'specialty': 'Biology & Chemistry',
      'mentees': 15,
      'rating': 4.9,
    },
    {
      'name': 'Neha Sharma',
      'exam': 'JEE Advanced',
      'score': '99.5%ile',
      'college': 'IIT Bombay',
      'specialty': 'Physics & Math',
      'mentees': 12,
      'rating': 4.8,
    },
    {
      'name': 'Arjun Kapoor',
      'exam': 'CLAT',
      'score': '135',
      'college': 'NLU Delhi',
      'specialty': 'Legal Reasoning',
      'mentees': 8,
      'rating': 4.7,
    },
    {
      'name': 'Priya Gupta',
      'exam': 'CUET',
      'score': '345',
      'college': 'Delhi University',
      'specialty': 'English & Hindi',
      'mentees': 10,
      'rating': 4.8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mentorship', style: Theme.of(context).textTheme.titleLarge),
        elevation: 0,
        backgroundColor: BodmasColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
        children: [
          // Header
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Learn from Toppers',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Get mentored by successful exam toppers',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Mentors List
          ...List.generate(
            _mentors.length,
            (index) => _buildMentorCard(context, _mentors[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildMentorCard(BuildContext context, Map<String, dynamic> mentor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: BodmasColors.primaryColor.withOpacity(0.2),
                  child: const Icon(Icons.person, size: 40),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mentor['name'],
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        '${mentor['exam']} | ${mentor['college']}',
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text('${mentor['rating']}', style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatColumn('Score', '${mentor['score']}'),
                _buildStatColumn('Specialty', '${mentor['specialty']}'),
                _buildStatColumn('Mentees', '${mentor['mentees']}'),
              ],
            ),
            const SizedBox(height: 12),
            // Connect Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _connectMentor(context, mentor),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BodmasColors.primaryColor,
                ),
                child: const Text('Connect with Mentor'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }

  void _connectMentor(BuildContext context, Map<String, dynamic> mentor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Connect with Mentor'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mentor: ${mentor['name']}'),
            const SizedBox(height: 12),
            const Text('Choose a plan:'),
            const SizedBox(height: 12),
            _buildPlanOption('1 Month', '₹999'),
            const SizedBox(height: 8),
            _buildPlanOption('3 Months', '₹2499'),
            const SizedBox(height: 8),
            _buildPlanOption('6 Months', '₹4499'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanOption(String duration, String price) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: BodmasColors.primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(duration),
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
