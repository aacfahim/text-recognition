import 'package:flutter/material.dart';
import 'package:text_recognition_app/pages/document_scanner.dart';
import 'package:text_recognition_app/pages/home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomePageScanner()));
                },
                child: Text("google_mlkit_document_scanner")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text("google_mlkit_text_recognition"))
          ],
        ),
      ),
    );
  }
}
