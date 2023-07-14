import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hw2text/controllers/api.dart';
import 'package:hw2text/controllers/image_controller.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  XFile? _image;
  CroppedFile? _croppedFile;
  String? detectedNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 8,
            child: Container(
              child: Center(
                child: Text(detectedNumber ?? "Nothing detected"),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  Utils.getImage()
                      .then((value) => Utils.cropImage(value!))
                      .then((value) =>
                          Utils.encodeImageFileToBase64(File(value!.path)))
                      .then((value) => Api.recognizeHandwrittenNumber(value))
                      .then((value) => setState(() {
                            detectedNumber = value;
                          }));
                },
                child: const Text('Take a photo'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
