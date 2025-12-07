import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _notifications = [
      {
        'title': 'NEET 2025 Registration Open',
        'description': 'Registration for NEET 2025 is now open. Register before 15th December.',
        'time': '2 hours ago',
        'type': 'exam',
        'isRead': false,
      },
      {
        'title': 'New Scholarship Opportunity',
        'description': 'Merit-based scholarship worth ₹2 lakhs available for toppers.',
        'time': '1 day ago',
        'type': 'scholarship',
        'isRead': false,
      },
      {
        'title': 'Counsellor Available',
        'description': 'Dr. Rajesh Kumar is now available for consultation.',
        'time': '2 days ago',
        'type': 'counselling',
        'isRead': true,
      },
      {
        'title': 'New Blog Published',
        'description': 'Top 10 Tips to Crack NEET 2025 - Read now!',
        'time': '3 days ago',
        'type': 'blog',
        'isRead': true,
      },
      {
        'title': 'Mentorship Program Started',
        'description': 'Join our mentorship program and get guided by toppers.',
        'time': '1 week ago',
        'type': 'mentorship',
        'isRead': true,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: Theme.of(context).textTheme.titleLarge),
        elevation: 0,
        backgroundColor: BodmasColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(BodmasConstants.paddingMedium),
        itemCount: _notifications.length,
        itemBuilder: (context, index) => _buildNotificationCard(
          context,
          _notifications[index],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
      BuildContext context, Map<String, dynamic> notification) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: notification['isRead'] ? Colors.white : BodmasColors.primaryColor.withOpacity(0.05),
          border: Border(
            left: BorderSide(
              width: 5,
              color: _getTypeColor(notification['type']),
            ),
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(BodmasConstants.paddingMedium),
          leading: CircleAvatar(
            backgroundColor: _getTypeColor(notification['type']).withOpacity(0.1),
            child: Icon(
              _getTypeIcon(notification['type']),
              color: _getTypeColor(notification['type']),
            ),
          ),
          title: Text(
            notification['title'],
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: notification['isRead'] ? FontWeight.normal : FontWeight.bold,
                ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(notification['description'], maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 8),
              Text(notification['time'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          trailing: !notification['isRead']
              ? Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: BodmasColors.primaryColor,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'exam':
        return Colors.blue;
      case 'scholarship':
        return Colors.green;
      case 'counselling':
        return Colors.purple;
      case 'blog':
        return Colors.orange;
      case 'mentorship':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'exam':
        return Icons.quiz;
      case 'scholarship':
        return Icons.card_giftcard;
      case 'counselling':
        return Icons.support_agent;
      case 'blog':
        return Icons.article;
      case 'mentorship':
        return Icons.psychology;
      default:
        return Icons.notifications;
    }
  }
}
// Extension for Border.left (left border)
extension BorderExtension on Border {
  static Border left({required double width, required Color color}) {
    return Border(left: BorderSide(width: width, color: color));
  }
}

// Helper function to create left border
Border createLeftBorder({required double width, required Color color}) {
  return Border(left: BorderSide(width: width, color: color));
}
