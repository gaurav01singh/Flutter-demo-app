import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/constants.dart';

class CutoffScreen extends StatefulWidget {
  const CutoffScreen({super.key});
  @override
  State<CutoffScreen> createState() => _CutoffScreenState();
}

class _CutoffScreenState extends State<CutoffScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Paid Cutoff', style: Theme.of(context).textTheme.titleLarge)),
      body: ListView(
        padding: EdgeInsets.all(BodmasConstants.paddingMedium),
        children: [
          _buildCourseCard('NEET 2025', 'UP', '650', 'Paid'),
          _buildCourseCard('JEE Main 2025', 'Delhi', '98.5%', 'Paid'),
          _buildCourseCard('CLAT 2025', 'Maharashtra', '125', 'Paid'),
          _buildCourseCard('CUET 2025', 'Bihar', '320', 'Paid'),
        ],
      ),
    );
  }

  Widget _buildCourseCard(String exam, String state, String cutoff, String type) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: CircleAvatar(
          backgroundColor: BodmasColors.primaryColor.withOpacity(0.1),
          child: Icon(Icons.trending_up, color: BodmasColors.primaryColor),
        ),
        title: Text(exam, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$state State'),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.confirmation_number, size: 16, color: BodmasColors.accentColor),
                const SizedBox(width: 4),
                Text(cutoff, style: TextStyle(color: BodmasColors.accentColor, fontWeight: FontWeight.bold)),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(type, style: const TextStyle(color: Colors.orange, fontSize: 12)),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _showCutoffDetails(context),
      ),
    );
  }

  void _showCutoffDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detailed Cutoff'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('General Category: 650'),
            Text('OBC: 640'),
            Text('SC/ST: 600'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }
}
