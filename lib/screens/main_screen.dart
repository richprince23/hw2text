import 'dart:convert';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Utils.clearImage();
  }

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
                child: Text(detectedNumber ?? "Nothing detected",
                    style: TextStyle(fontSize: 30)),
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
                      .then((value) => Api.recognizeText(value))
                      .then(
                        (value) => setState(
                          () {
                            Map<String, dynamic> responseMap =
                                json.decode(value!);
                            detectedNumber =
                                responseMap['ParsedResults'][0]['ParsedText'];
                          },
                        ),
                      );
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
