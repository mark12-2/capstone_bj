import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Notification {
  String id;
  String title;
  String notif;
  String senderName;
  bool isRead;

  Notification({
    required this.id,
    required this.title,
    required this.notif,
    required this.senderName,
    this.isRead = false,
  });

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id'],
      title: map['title'],
      notif: map['notif'],
      senderName: map['senderName'],
      isRead: map['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'notif': notif,
      'senderName': senderName,
      'isRead': isRead,
    };
  }
}

class NotificationProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _notificationsCollection;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<String> _unreadNotificationsIds = [];

  NotificationProvider() {
    _notificationsCollection = _firestore.collection('notifications');
    init();
  }

  List<Notification> _notifications = [];
  int _unreadNotifications = 0;

  List<Notification> get notifications => _notifications;
  int get unreadNotifications => _unreadNotifications;

  void init() {
    final userId = _auth.currentUser!.uid;
    _notificationsCollection =
        _firestore.collection('users').doc(userId).collection('notifications');

    _notificationsCollection.snapshots().listen((snapshot) {
      _notifications = snapshot.docs
          .map(
              (doc) => Notification.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      _unreadNotifications =
          _notifications.where((notification) => !notification.isRead).length;
      notifyListeners();
    });
  }

  Future<void> addNotification(Notification notification) async {
    await _notificationsCollection.add(notification.toMap());
    notifyListeners();
  }

  void markAsRead() async {
    for (var id in _unreadNotificationsIds) {
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(id)
          .update({'isRead': true});
    }
    _unreadNotifications = 0;
    _unreadNotificationsIds = [];
    notifyListeners();
  }

  Future<void> commentNotification(
      {required String receiverId,
      required String senderId,
      required String senderName,
      required String notif}) async {
    String? senderName;
    // Fetch the senderName from Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .get()
        .then((value) => senderName = value.data()?['name']);

    if (senderName != null) {
      Notification notification = Notification(
        id: _notificationsCollection.doc().id,
        title: 'New Message',
        notif: notif,
        senderName: senderName!,
        isRead: false,
      );

      await _firestore
          .collection('users')
          .doc(receiverId)
          .collection('notifications')
          .add(notification.toMap());
      notifyListeners();
    }
  }
}



// // Send notification
//       final notificationProvider =
//           Provider.of<NotificationProvider>(context, listen: false);
//       await notificationProvider.createMessageNotification(
//         receiverId: receiverId,
//         senderId: _auth.currentUser!.uid,
//         senderName: _auth.currentUser!.displayName ?? 'Unknown',
//        notif: _commentTextController.text,
//       );