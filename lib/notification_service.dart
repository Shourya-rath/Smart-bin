import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final SupabaseClient _supabase = Supabase.instance.client;
  StreamSubscription<List<Map<String, dynamic>>>? _notificationsSubscription;

  NotificationService._internal();

  Future<void> initialize() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _startListeningForNotifications();
  }

  void _startListeningForNotifications() {
    _notificationsSubscription = _supabase
        .from('notifications')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .listen((List<Map<String, dynamic>> notifications) {
      if (notifications.isNotEmpty) {
        _showNewNotification(notifications.last);
      }
    });
  }

  Future<void> _showNewNotification(Map<String, dynamic> notification) async {
    const int notificationId = 0;
    const String title = 'New Notification';
    final String message = notification['message'] ?? 'New object detected!';
    
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'notifications_channel',
      'App Notifications',
      channelDescription: 'Notifications for app updates and alerts',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      playSound: true,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      message,
      platformChannelSpecifics,
      payload: 'New object detected!',
    );
  }

  void dispose() {
    _notificationsSubscription?.cancel();
  }
}
