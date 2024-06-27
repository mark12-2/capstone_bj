import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Notification {
  String id;
  String title;
  String message;
  String senderName;
  bool isRead;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.senderName,
    this.isRead = false,
  });

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id'],
      title: map['title'],
      message: map['message'],
      senderName: map['senderName'],
      isRead: map['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'senderName': senderName,
      'isRead': isRead,
    };
  }
}

class NotificationProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _notificationsCollection;

  NotificationProvider() {
    _notificationsCollection = _firestore.collection('notifications');
    init();
  }

  List<Notification> _notifications = [];
  int _unreadNotifications = 0;

  List<Notification> get notifications => _notifications;
  int get unreadNotifications => _unreadNotifications;

  void init() {
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

  Future<void> markAsRead(String notificationId) async {
    await _notificationsCollection.doc(notificationId).update({'isRead': true});
    notifyListeners();
  }

  Future<void> createMessageNotification(
      {required String receiverId,
      required String senderName,
      required String message}) async {
    Notification notification = Notification(
      id: _notificationsCollection.doc().id,
      title: 'New Message',
      message: message,
      senderName: senderName,
      isRead: false,
    );

    await _notificationsCollection.add(notification.toMap());
    notifyListeners();
  }
}
