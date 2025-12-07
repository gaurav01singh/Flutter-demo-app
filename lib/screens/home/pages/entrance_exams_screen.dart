import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class EntranceExamsScreen extends StatelessWidget {
  const EntranceExamsScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> _exams = const [
    {
      'name': 'NEET 2025',
      'date': '5 May 2025',
      'registrationDeadline': '15 Dec 2024',
      'examMode': 'Offline (OMR)',
      'duration': '3 hours',
      'totalQuestions': 180,
      'seats': 'Total 32,000+ seats',
    },
    {
      'name': 'JEE Main 2025',
      'date': '22-29 January 2025',
      'registrationDeadline': '31 Dec 2024',
      'examMode': 'Online (CBT)',
      'duration': '3 hours',
      'totalQuestions': 90,
      'seats': 'Total 16,000+ seats',
    },
    {
      'name': 'CLAT 2025',
      'date': '22 December 2024',
      'registrationDeadline': '15 Dec 2024',
      'examMode': 'Online (CBT)',
      'duration': '2 hours',
      'totalQuestions': 120,
      'seats': 'Total 3,500+ seats',
    },
    {
      'name': 'CUET 2025',
      'date': 'April-May 2025',
      'registrationDeadline': '31 Dec 2024',
      'examMode': 'Online (CBT)',
      'duration': '45-60 min',
      'totalQuestions': '40-60',
      'seats': 'Varies per university',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrance Exams', style: Theme.of(context).textTheme.titleLarge),
        elevation: 0,
        backgroundColor: BodmasColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
        itemCount: _exams.length,
        itemBuilder: (context, index) => _buildExamCard(context, _exams[index]),
      ),
    );
  }

  Widget _buildExamCard(BuildContext context, Map<String, dynamic> exam) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: BodmasColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.quiz, color: BodmasColors.primaryColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exam['name'],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(exam['date'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const SizedBox(height: 12),
                _buildDetailRow('Registration Deadline', exam['registrationDeadline']),
                _buildDetailRow('Exam Mode', exam['examMode']),
                _buildDetailRow('Duration', exam['duration']),
                _buildDetailRow('Total Questions', exam['totalQuestions'].toString()),
                _buildDetailRow('Available Seats', exam['seats']),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _viewSyllabus(context, exam),
                        child: const Text('View Syllabus'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _registerExam(context, exam),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BodmasColors.primaryColor,
                        ),
                        child: const Text('Register Now'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _viewSyllabus(BuildContext context, Map<String, dynamic> exam) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening syllabus for ${exam['name']}...')),
    );
  }

  void _registerExam(BuildContext context, Map<String, dynamic> exam) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Redirecting to registration for ${exam['name']}...')),
    );
  }
}
