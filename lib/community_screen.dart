import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildNgoCard(
                context,
                ngoName: 'Green Cities Network',
                description: 'Join Us in Making a Difference!',
                website: 'www.greencitiesnetwork.org',
              ),
              const SizedBox(height: 16),
              _buildNgoCard(
                context,
                ngoName: 'Clean Rivers Initiative',
                description: 'Join Us in Making a Difference!',
                website: 'www.cleanriversinitiative.org',
              ),
              const SizedBox(height: 16),
              _buildNgoCard(
                context,
                ngoName: 'Earth Guardians India',
                description: 'Join Us in Making a Difference!',
                website: 'www.earthguardiansindia.org',
              ),
              // Add more NGO cards as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNgoCard(BuildContext context,
      {required String ngoName,
      required String description,
      required String website}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      AssetImage('assets/images/ngoProfile.jpg'), // NGO logo
                ),
                const SizedBox(width: 12),
                Text(
                  ngoName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/images/ngoImage.png', // NGO image
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Handle "View More" button action
                  },
                  child: const Text('View More'),
                ),
                OutlinedButton(
                  onPressed: () {
                    // Handle "View Site" button action
                    _launchURL(website);
                  },
                  child: const Text('View Site'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    // Implement URL launch functionality here
    // For example, you can use the url_launcher package
  }
}
