import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class CounsellingScreen extends StatelessWidget {
  const CounsellingScreen({super.key});

  final List<Map<String, dynamic>> _counsellors = const [
    {
      'name': 'Dr. Rajesh Kumar',
      'specialty': 'Medical Counselling',
      'experience': '12 years',
      'rating': 4.9,
      'price': 500,
      'availability': 'Available Today',
      'reviews': 245,
    },
    {
      'name': 'Prof. Sharma',
      'specialty': 'Engineering Counselling',
      'experience': '15 years',
      'rating': 4.8,
      'price': 450,
      'availability': 'Available Tomorrow',
      'reviews': 189,
    },
    {
      'name': 'Ms. Priya Verma',
      'specialty': 'Law & CLAT Counselling',
      'experience': '8 years',
      'rating': 4.7,
      'price': 400,
      'availability': 'Available Today',
      'reviews': 127,
    },
    {
      'name': 'Mr. Arun Patel',
      'specialty': 'Study Abroad Counselling',
      'experience': '10 years',
      'rating': 4.8,
      'price': 600,
      'availability': 'Available in 2 days',
      'reviews': 203,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paid Counselling', style: Theme.of(context).textTheme.titleLarge),
        elevation: 0,
        backgroundColor: BodmasColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
        children: [
          // Header Card
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expert Counselling Sessions',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Book 1-on-1 sessions with experienced counsellors',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Counsellors List
          ...List.generate(
            _counsellors.length,
            (index) => _buildCounsellorCard(context, _counsellors[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildCounsellorCard(BuildContext context, Map<String, dynamic> counsellor) {
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
                  backgroundColor: BodmasColors.primaryColor.withOpacity(0.1),
                  child: Text(
                    counsellor['name'],
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        counsellor['name'],
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        counsellor['specialty'],
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${counsellor['rating']} (${counsellor['reviews']} reviews)',
                            style: const TextStyle(fontSize: 12),
                          ),
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
            // Details Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Experience', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Text(counsellor['experience'],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Price (per session)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Text('₹${counsellor['price']}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Text(counsellor['availability'],
                        style: const TextStyle(color: BodmasColors.accentColor, fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Book Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showBookingConfirmation(context, counsellor),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BodmasColors.primaryColor,
                ),
                child: const Text('Book Session'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingConfirmation(BuildContext context, Map<String, dynamic> counsellor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Book Session'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Counsellor: ${counsellor['name']}'),
            const SizedBox(height: 8),
            Text('Price: ₹${counsellor['price']}'),
            const SizedBox(height: 8),
            const Text('Duration: 60 minutes'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Session booked successfully!')),
              );
            },
            child: const Text('Confirm Booking'),
          ),
        ],
      ),
    );
  }
}
