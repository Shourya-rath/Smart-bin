import 'package:flutter/material.dart';

class NotificationDetail extends StatelessWidget {
  final String imageUrl;
  final String date;
  final String imageName;

  const NotificationDetail({
    super.key,
    required this.imageUrl,
    required this.date,
    required this.imageName,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure arguments are correctly received
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final imageUrl = args['imageUrl'] ?? '';
    final date = args['date'] ?? '';
    final imageName = args['imageName'] ?? '';

    print('Image URL: $imageUrl'); // Debugging
    print('Date: $date'); // Debugging
    print('Image Name: $imageName'); // Debugging

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'File Name: $imageName',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Created At: $date',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 300,
                      errorBuilder: (context, error, stackTrace) {
                        // Handle image loading error
                        return const Icon(Icons.error, size: 100);
                      },
                    )
                  : const Text('Image not available'),
            ),
          ],
        ),
      ),
    );
  }
}
