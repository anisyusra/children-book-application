import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class UploadBookScreen extends StatefulWidget {
  const UploadBookScreen({Key? key}) : super(key: key);

  @override
  State<UploadBookScreen> createState() => _UploadBookScreenState();
}

class _UploadBookScreenState extends State<UploadBookScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> uploadPdf(String fileName, File file) async {
    final refrence =
        FirebaseStorage.instance.ref().child("pdfs/$fileName.pdf");

    final uploadTask = refrence.putFile(file);

    await uploadTask.whenComplete(() {});

    final downloadLink = await refrence.getDownloadURL();

    return downloadLink;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  _pickPdfFromStorage();
                },
                child: const Text("Upload PDF"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickPdfFromStorage() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      final File file = File(result.files.single.path!);
      final String fileName = result.files.single.name;

      final appDir = await getExternalStorageDirectory();
      final savedPdfFile = await file.copy('${appDir!.path}/$fileName');

      final downloadLink = await uploadPdf(fileName, savedPdfFile);

      await _firebaseFirestore.collection("pdfs").add({
        "name": fileName,
        "url": downloadLink,
      });

      print("Pdf uploaded successfully");

      // TODO: Perform any additional operations or UI updates after uploading the PDF.
    }
  }
}
