import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> _blogs = const [
    {
      'title': 'Top 10 Tips to Crack NEET 2025',
      'author': 'Dr. Rajesh Kumar',
      'date': '2 days ago',
      'category': 'NEET',
      'readTime': '5 min',
      'excerpt': 'Learn the proven strategies that helped thousands of students clear NEET with high scores.',
      'views': 5420,
    },
    {
      'title': 'JEE Advanced: Complete Preparation Guide',
      'author': 'Prof. Sharma',
      'date': '4 days ago',
      'category': 'JEE',
      'readTime': '8 min',
      'excerpt': 'Master the art of solving complex problems with our comprehensive JEE preparation guide.',
      'views': 3210,
    },
    {
      'title': 'Study Abroad After 12th: Your Complete Roadmap',
      'author': 'Counsellor Priya',
      'date': '1 week ago',
      'category': 'Study Abroad',
      'readTime': '6 min',
      'excerpt': 'Understand the step-by-step process of applying to universities abroad.',
      'views': 8950,
    },
    {
      'title': 'Understanding Medical College Cutoffs',
      'author': 'Dr. Patel',
      'date': '1 week ago',
      'category': 'Cutoff',
      'readTime': '4 min',
      'excerpt': 'Demystifying how cutoff scores are calculated and what they mean for your admission.',
      'views': 4123,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs', style: Theme.of(context).textTheme.titleLarge),
        elevation: 0,
        backgroundColor: BodmasColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
        itemCount: _blogs.length,
        itemBuilder: (context, index) => _buildBlogCard(context, _blogs[index]),
      ),
    );
  }

  Widget _buildBlogCard(BuildContext context, Map<String, dynamic> blog) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showBlogDetails(context, blog),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: BodmasColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  blog['category'],
                  style: const TextStyle(
                    color: BodmasColors.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Title
              Text(
                blog['title'],
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // Excerpt
              Text(
                blog['excerpt'],
                style: const TextStyle(color: Colors.grey, height: 1.5),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              // Metadata
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          blog['author'],
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          blog['date'],
                          style: const TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.block_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(blog['readTime'], style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      const Icon(Icons.visibility_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('${blog['views']}', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Read More Button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _showBlogDetails(context, blog),
                  child: const Text('Read More →'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBlogDetails(BuildContext context, Map<String, dynamic> blog) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Blog'),
            elevation: 0,
            backgroundColor: BodmasColors.primaryColor,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: BodmasColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    blog['category'],
                    style: const TextStyle(
                      color: BodmasColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  blog['title'],
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: BodmasColors.primaryColor.withOpacity(0.1),
                      child: Text(blog['author']),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(blog['author'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(blog['date'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(blog['excerpt'],
                          style: const TextStyle(fontSize: 16, height: 1.8, color: Colors.black87)),
                      const SizedBox(height: 20),
                      const Text(
                        'This comprehensive guide covers everything you need to know to succeed in your entrance exams. From effective study techniques to time management strategies, we have compiled years of expertise to help you achieve your goals. Read on to discover the secrets to cracking your entrance exam.',
                        style: TextStyle(fontSize: 14, height: 1.8, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
