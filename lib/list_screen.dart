import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

class NotificationsList extends StatefulWidget {
  const NotificationsList({super.key});

  @override
  NotificationsListState createState() => NotificationsListState();
}

class NotificationsListState extends State<NotificationsList> {
  final SupabaseClient _supabase = Supabase.instance.client;
  Stream<List<Map<String, dynamic>>>? _notificationsStream;

  @override
  void initState() {
    super.initState();
    _notificationsStream = _supabase
        .from('notifications')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff004d99),
              Color(0xff00aaff),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _notificationsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No notifications found.'));
            }

            final notifications = snapshot.data!;

            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                final date = notification['created_at'] as String;
                final imageUrl = notification['public_url'] as String;
                final imageName = notification['image_name'] as String;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: const Text('New Object detected'),
                    subtitle: Text('Date: $date'),
                    trailing: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/details',
                          arguments: {
                            'imageUrl': imageUrl,
                            'date': date,
                            'imageName': imageName,
                          },
                        );
                      },
                      child: const Text('View Details'),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/home');
        },
        tooltip: 'Back to Home',
        child: const Icon(Icons.home),
      ),
    );
  }
}

