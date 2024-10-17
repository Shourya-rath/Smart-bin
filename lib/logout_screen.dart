import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogOutScreen extends StatelessWidget {
  const LogOutScreen({super.key});

  Future<void> logOut(BuildContext context) async {
    try {
      await Supabase.instance.client.auth.signOut();
      Navigator.pushReplacementNamed(context, '/start');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing out: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Out'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            logOut(context);
          },
          child: const Text('Log Out'),
        ),
      ),
    );
  }
}
