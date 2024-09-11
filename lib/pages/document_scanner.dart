import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker for XFile

class HomePageScanner extends StatefulWidget {
  const HomePageScanner({super.key});

  @override
  State<HomePageScanner> createState() => _HomePageScannerState();
}

class _HomePageScannerState extends State<HomePageScanner> {
  final DocumentScannerOptions _documentOptions = DocumentScannerOptions(
    documentFormat: DocumentFormat.jpeg, // Set the output document format
    mode: ScannerMode.filter, // Enable filters
    pageLimit: 1, // Limit to 1 page
    isGalleryImport: true, // Enable gallery import
  );

  DocumentScanner? _documentScanner;
  List<XFile>? _scannedImages; // Change List<String> to List<XFile>
  String? _scannedPdf;

  @override
  void initState() {
    super.initState();
    _documentScanner = DocumentScanner(options: _documentOptions);
  }

  Future<void> _scanDocument() async {
    try {
      final DocumentScanningResult result =
          await _documentScanner!.scanDocument();

      setState(() {
        _scannedPdf = result.pdf as String?;
        _scannedImages =
            result.images as List<XFile>?; // Ensure images are of type XFile
      });
    } catch (e) {
      print("Error scanning document: $e");
    }
  }

  @override
  void dispose() {
    _documentScanner?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Document Scanner"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_scannedImages != null)
              ..._scannedImages!.map(
                (image) => Image.file(
                  File(image.path), // Use the path property of XFile
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            if (_scannedPdf != null)
              Text(
                "PDF Scanned: $_scannedPdf",
                style: const TextStyle(fontSize: 18),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scanDocument,
              child: const Text('Scan Document'),
            ),
          ],
        ),
      ),
    );
  }
}
