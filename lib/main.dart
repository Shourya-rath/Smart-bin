import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_screen.dart';
import 'report_screen.dart';
import 'logout_screen.dart';
import 'start_screen.dart';
import 'list_screen.dart';
import 'detail_screen.dart';
import 'quiz_screen.dart';
import 'community_screen.dart';
import 'notification_service.dart'; // Import the notification service

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://xslkffheeuxdwftukkle.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhzbGtmZmhlZXV4ZHdmdHVra2xlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyNjQ2NDc1NiwiZXhwIjoyMDQyMDQwNzU2fQ.AsMPdWX598TKSQqZPli6V8aalG3WHTsR898YqXWzYYA",
  );

  final notificationService = NotificationService();
  await notificationService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/start',
      routes: {
        '/start': (context) => const StartScreen(),
        '/auth': (context) => const AuthScreen(),
        '/home': (context) => const HomeScreen(),
        '/report': (context) => const ReportScreen(),
        '/logout': (context) => const LogOutScreen(),
        '/notifications': (context) => const NotificationsList(),
        '/details': (context) => const NotificationDetail(
            imageUrl: '', date: '', imageName: ''),
        '/quiz': (context) => const QuizScreen(),
        '/community': (context) => const CommunityScreen(),
      },
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff105c9b),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              title: const Text('Quiz'),
              onTap: () {
                Navigator.pushNamed(context, '/quiz');
              },
            ),
            ListTile(
              title: const Text('Community'),
              onTap: () {
                Navigator.pushNamed(context, '/community');
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              title: const Text('Help & Feedback'),
              onTap: () {
                Navigator.pushNamed(context, '/help');
              },
            ),
            ListTile(
              title: const Text('Log out'),
              onTap: () {
                const outlogger = LogOutScreen();
                outlogger.logOut(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xdd5c6ff2),
        title: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: const Text('Dashboard',
              style: TextStyle(color: Color(0xff000000), fontSize: 20)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff15042c),
              Color(0xff391469),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 24), // Gap above the cards

              // Row for compartment cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Compartment 1 with button
                  Column(
                    children: [
                      _buildCompartmentCard(
                        'Compartment 1: 65% Full',
                        'Last Updated: 02-09-2024 04:14',
                        'assets/images/recyclable.png',
                      ),
                      const SizedBox(height: 8),
                      // View Location Button for Compartment 1
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MapScreen(
                                initialCenter: LatLng(
                                    24.619341816682663, 73.8547429409812),
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xffffffff),
                          side: const BorderSide(
                              color: Color(0xffffffff), width: 2),
                        ),
                        child: const Text('View Location'),
                      ),
                      const Text(
                        'Geetanjali institute of \ntechnical studies',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ), // Location text
                    ],
                  ),

                  // Compartment 2 with button
                  Column(
                    children: [
                      _buildCompartmentCard(
                        'Compartment 2: 55% Full',
                        'Last Updated: 02-09-2024 04:14',
                        'assets/images/nonRecyclable.png',
                      ),
                      const SizedBox(height: 8),
                      // View Location Button for Compartment 2
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MapScreen(
                                initialCenter: LatLng(24.59104283062624, 73.69012354387287),
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xffffffff),
                          side: const BorderSide(
                              color: Color(0xffffffff), width: 2),
                        ),
                        child: const Text('View Location'),
                      ),
                      const Text(
                        'Chetak \nCircle',
                        
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ), // Location text
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50), // Additional space below the cards

              // Report button
              SizedBox(
                width: 300,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/report');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xffffffff),
                    side: const BorderSide(color: Color(0xffffffff), width: 2),
                  ),
                  child: const Text('Report Problem'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompartmentCard(
      String title, String lastUpdated, String imagePath) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              height: 100,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            lastUpdated,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  final LatLng initialCenter;

  const MapScreen({super.key, required this.initialCenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map View'),
        backgroundColor: const Color(0xffed6060),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: initialCenter,
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: initialCenter,
                child : const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
