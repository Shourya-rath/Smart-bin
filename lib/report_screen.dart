import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  ReportScreenState createState() => ReportScreenState();
}

class ReportScreenState extends State<ReportScreen> {
  String? _selectedProblem;
  final _additionalInfoController = TextEditingController();

  Future<void> _submitReport() async {
    // Show a dialog box saying the problem was reported
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Problem Reported'),
          content: const Text('Your report has been submitted successfully.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Return to the previous screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff004d40), // Darker background color
        title:
            const Text('Report Problem', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Problem:'),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: _selectedProblem,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                    value: 'text_1', child: Text('Option 1: text_1')),
                DropdownMenuItem(
                    value: 'text_2', child: Text('Option 2: text_2')),
                DropdownMenuItem(
                    value: 'text_3', child: Text('Option 3: text_3')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedProblem = value;
                });
              },
              hint: const Text('Choose an option'),
            ),
            const SizedBox(height: 16),
            const Text('Additional Information:'),
            const SizedBox(height: 8),
            TextField(
              controller: _additionalInfoController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter additional information',
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _submitReport,
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
