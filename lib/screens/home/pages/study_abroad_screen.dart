import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class StudyAbroadScreen extends StatefulWidget {
  const StudyAbroadScreen({Key? key}) : super(key: key);

  @override
  State<StudyAbroadScreen> createState() => _StudyAbroadScreenState();
}

class _StudyAbroadScreenState extends State<StudyAbroadScreen> {
  final List<Map<String, dynamic>> _countries = const [
    {
      'country': 'USA',
      'flagEmoji': '🇺🇸',
      'universities': 250,
      'averageCost': '\$25,000-60,000/year',
      'exams': 'SAT, ACT, GRE, GMAT',
      'visaProcessing': '2-3 months',
      'topUniversities': ['Harvard', 'MIT', 'Stanford', 'Yale'],
    },
    {
      'country': 'Canada',
      'flagEmoji': '🇨🇦',
      'universities': 200,
      'averageCost': 'CAD 15,000-40,000/year',
      'exams': 'SAT, IELTS, TOEFL',
      'visaProcessing': '3-4 months',
      'topUniversities': ['University of Toronto', 'UBC', 'McGill'],
    },
    {
      'country': 'UK',
      'flagEmoji': '🇬🇧',
      'universities': 150,
      'averageCost': '£12,000-35,000/year',
      'exams': 'A-Levels, IELTS',
      'visaProcessing': '2-3 weeks',
      'topUniversities': ['Oxford', 'Cambridge', 'LSE'],
    },
    {
      'country': 'Australia',
      'flagEmoji': '🇦🇺',
      'universities': 180,
      'averageCost': 'AUD 20,000-50,000/year',
      'exams': 'IELTS, PTE',
      'visaProcessing': '4-6 weeks',
      'topUniversities': ['University of Melbourne', 'ANU', 'UNSW'],
    },
    {
      'country': 'Germany',
      'flagEmoji': '🇩🇪',
      'universities': 300,
      'averageCost': '€0-1,000/semester',
      'exams': 'TestDaF, IELTS',
      'visaProcessing': '6-8 weeks',
      'topUniversities': ['Technical University Munich', 'Heidelberg'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Abroad', style: Theme.of(context).textTheme.titleLarge),
        elevation: 0,
        backgroundColor: BodmasColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
        itemCount: _countries.length,
        itemBuilder: (context, index) => _buildCountryCard(context, _countries[index]),
      ),
    );
  }

  Widget _buildCountryCard(BuildContext context, Map<String, dynamic> country) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Country Header
          Container(
            padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
            decoration: BoxDecoration(
              color: BodmasColors.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Text(country['flagEmoji'], style: const TextStyle(fontSize: 40)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      country['country'],
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      '${country['universities']} Universities',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Details
          Padding(
            padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Average Cost', country['averageCost']),
                const SizedBox(height: 8),
                _buildDetailRow('Entrance Exams', country['exams']),
                const SizedBox(height: 8),
                _buildDetailRow('Visa Processing', country['visaProcessing']),
                const SizedBox(height: 16),
                const Text(
                  'Top Universities',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: (country['topUniversities'] as List).map<Widget>((uni) {
                    return Chip(
                      label: Text(uni),
                      backgroundColor: BodmasColors.primaryColor.withOpacity(0.1),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _showMoreInfo(context, country),
                        child: const Text('More Info'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _bookConsultation(context, country),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BodmasColors.primaryColor,
                        ),
                        child: const Text('Book Consultation'),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  void _showMoreInfo(BuildContext context, Map<String, dynamic> country) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(country['country']),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDialogRow('Universities', country['universities'].toString()),
              _buildDialogRow('Cost Range', country['averageCost']),
              _buildDialogRow('Entrance Exams', country['exams']),
              _buildDialogRow('Visa Processing', country['visaProcessing']),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _bookConsultation(BuildContext context, Map<String, dynamic> country) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Consultation booking for ${country['country']} initiated!')),
    );
  }

  Widget _buildDialogRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
