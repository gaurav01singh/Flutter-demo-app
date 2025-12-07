import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../utils/constants.dart';

class CollegesScreen extends StatefulWidget {
  const CollegesScreen({Key? key}) : super(key: key);

  @override
  State<CollegesScreen> createState() => _CollegesScreenState();
}

class _CollegesScreenState extends State<CollegesScreen> {
  String _selectedExam = 'All';
  final List<String> _exams = ['All', 'NEET', 'JEE', 'CLAT', 'CUET'];

  final List<Map<String, dynamic>> _colleges = [
    {
      'name': 'AIIMS Delhi',
      'city': 'New Delhi',
      'exam': 'NEET',
      'cutoff': 680,
      'image': 'https://via.placeholder.com/300x200?text=AIIMS',
      'rating': 4.8,
      'seats': 87,
    },
    {
      'name': 'IIT Bombay',
      'city': 'Mumbai',
      'exam': 'JEE',
      'cutoff': 98.5,
      'image': 'https://via.placeholder.com/300x200?text=IIT',
      'rating': 4.9,
      'seats': 60,
    },
    {
      'name': 'NLU Delhi',
      'city': 'New Delhi',
      'exam': 'CLAT',
      'cutoff': 125,
      'image': 'https://via.placeholder.com/300x200?text=NLU',
      'rating': 4.7,
      'seats': 45,
    },
    {
      'name': 'Delhi University',
      'city': 'Delhi',
      'exam': 'CUET',
      'cutoff': 320,
      'image': 'https://via.placeholder.com/300x200?text=DU',
      'rating': 4.6,
      'seats': 200,
    },
  ];

  List<Map<String, dynamic>> get _filteredColleges {
    if (_selectedExam == 'All') return _colleges;
    return _colleges.where((c) => c['exam'] == _selectedExam).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colleges', style: Theme.of(context).textTheme.titleLarge),
        elevation: 0,
        backgroundColor: BodmasColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
            child: Row(
              children: _exams
                  .map((exam) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(exam),
                          selected: _selectedExam == exam,
                          onSelected: (selected) {
                            setState(() => _selectedExam = exam);
                          },
                          selectedColor: BodmasColors.primaryColor,
                          labelStyle: TextStyle(
                            color: _selectedExam == exam ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          // Colleges List
          Expanded(
            child: _filteredColleges.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.school_outlined, size: 80, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text('No colleges found', style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
                    itemCount: _filteredColleges.length,
                    itemBuilder: (context, index) {
                      final college = _filteredColleges[index];
                      return _buildCollegeCard(context, college);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollegeCard(BuildContext context, Map<String, dynamic> college) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: college['image'],
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey,
                child: const Icon(Icons.school),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey,
                child: const Icon(Icons.school),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            college['name'],
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(college['city'], style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        Text(college['rating'].toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatChip('Cutoff', college['cutoff'].toString(), Colors.blue),
                    _buildStatChip('Seats', college['seats'].toString(), Colors.green),
                    _buildStatChip('Exam', college['exam'], Colors.orange),
                  ],
                ),
                const SizedBox(height: 12),
                // View Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showCollegeDetails(context, college),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BodmasColors.primaryColor,
                    ),
                    child: const Text('View Details'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  void _showCollegeDetails(BuildContext context, Map<String, dynamic> college) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                college['name'],
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              _buildDetailRow('Location', college['city']),
              _buildDetailRow('Entrance Exam', college['exam']),
              _buildDetailRow('Cutoff Score', college['cutoff'].toString()),
              _buildDetailRow('Seats Available', college['seats'].toString()),
              _buildDetailRow('Rating', '${college['rating']} / 5'),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to favorites!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BodmasColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Add to Favorites'),
                ),
              ),
            ],
          ),
        ),
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
}
