import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const HistoryPageApp());
}

class HistoryPageApp extends StatelessWidget {
  const HistoryPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HistoryPage(),
    );
  }
}

class HistoryPage extends StatelessWidget {
  final List<Map<String, String>> historyItems = [
    {
      "title": "Inspection - 26th Nov 2024",
      "description": "Damage Type: Broken part",
      "details": "see more",
      "estimatedCost": "ksh 80800",
      "date": "26/11/2024",
      "pdfPath": "assets/pdf/pdf1.pdf",
    },
    {
      "title": "Inspection - 22nd November 2024",
      "description": "Damage Type: Crack",
      "details": "see more",
      "estimatedCost": "ksh 80800",
      "date": "22/11/2024",
      "pdfPath": "assets/pdf/pdf4.pdf",
    },
    {
      "title": "Inspection - 12th Nov 2024",
      "description": "Damage Type: Dent",
      "details": "see more",
      "estimatedCost": "ksh 102405",
      "date": "12/11/2024",
      "pdfPath": "assets/pdf/pdf2.pdf",
    },
    {
      "title": "Inspection - 5th Oct 2024",
      "description": "Damage Type: Scratch",
      "details": "see more",
      "estimatedCost": "ksh 50040",
      "date": "05/10/2024",
      "pdfPath": "assets/pdf/pdf3.pdf",
    },
  ];

  HistoryPage({super.key});

  Future<void> _openPDF(String pdfPath) async {
    try {
      // Open the PDF directly in the browser
      final url = Uri.parse('/$pdfPath'); // Root-relative path
      await launchUrl(url, mode: LaunchMode.platformDefault);
    } catch (e) {
      debugPrint('Error opening PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "Inspection History",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: historyItems.length,
        itemBuilder: (context, index) {
          final item = historyItems[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ExpansionTile(
                title: Text(
                  item["title"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                subtitle: Text(
                  item["description"]!,
                  style: const TextStyle(color: Colors.black87),
                ),
                trailing: Text(
                  item["date"]!,
                  style: const TextStyle(color: Colors.grey),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _openPDF(item["pdfPath"]!);
                          },
                          child: Row(
                            children: [
                              const Text(
                                "Details:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item["details"]!,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text(
                              "Estimated Cost:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item["estimatedCost"]!,
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
