import 'package:capstone/styles/textstyle.dart';
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(width: 1, color: Colors.grey),
                    ),
                    child: ListTile(
                      title: Text(
                        notification.senderName,
                        style: CustomTextStyle.semiBoldText,
                      ),
                      subtitle: Text(
                        notification.notif,
                        style: CustomTextStyle.regularText,
                      ),
                      // onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const MessagingPage(),
                      //     ),
                      //   );
                      // },
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
