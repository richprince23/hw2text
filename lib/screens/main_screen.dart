import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: Container(color: Colors.red),
          ),
          Flexible(
            flex: 5,
            child: Container(color: Colors.green),
          ),
          Flexible(
            flex: 1,
            child: Container(color: Colors.green),
          ),
        ],
      ),
    );
  }
}
