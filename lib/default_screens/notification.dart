import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/provider/notifications/notifications_provider.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
          if (notificationProvider.notifications.isEmpty) {
            return const Center(child: Text('No notifications'));
          }

          return ListView.builder(
            itemCount: notificationProvider.notifications.length,
            itemBuilder: (context, index) {
              final notification = notificationProvider.notifications[index];
              return ListTile(
                title: Text(notification.title),
                subtitle: Text(notification.message),
                trailing: IconButton(
                  icon: Icon(
                    notification.isRead ? Icons.check_circle : Icons.circle,
                    color: notification.isRead ? Colors.green : Colors.red,
                  ),
                  onPressed: () {
                    if (!notification.isRead) {
                      notificationProvider.markAsRead(notification.id);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
