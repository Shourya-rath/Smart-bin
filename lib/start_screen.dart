import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1f368c),
              Color(0xff4260d0),
              Color(0xff6a81d0),
              Color(0xff4260d0),
              Color(0xff1f368c),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Company logo at the top
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 20), // Add padding
              child: Opacity(
                opacity: 0.7, // Adjust the opacity level (0.0 to 1.0)
                child: Image.asset(
                  'assets/images/companyLogo.png',
                  fit: BoxFit
                      .contain, // Adjusts the logo to fit within the Padding
                ),
              ),
            ),
            const SizedBox(height: 20),
            // App logo in the center
            Image.asset(
              'assets/images/smartBinLogo.png',
              width: 200, // Adjust width as needed
              height: 200,
              // Adjust height as needed
            ),
            // const SizedBox(height: 20), // Space between logos and text
            const Text(
              'SampurnaBin',
              style: TextStyle(
                fontSize: 24, // Adjust font size as needed
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
             // Space between text and logos
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Team logo
                Image.asset(
                  'assets/images/teamLogo.png',
                  width: 150, // Adjust width as needed
                  height: 150, // Adjust height as needed
                ),
                const SizedBox(width: 20), // Space between logos
                // Hackathon logo
                Image.asset(
                  'assets/images/MSME_LOGO.jpg',
                  width: 150, // Adjust width as needed
                  height: 150, // Adjust height as needed
                ),
              ],
            ),
            const SizedBox(height: 50), // Space before the button
            // Arrow button at the bottom
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 20), // Padding from the bottom
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Color(0xff1f368c),
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/auth');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
