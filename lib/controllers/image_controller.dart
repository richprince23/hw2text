//function to get image via camera with filepicker

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  /// function to get image via camera with filepicker
  static Future<File?> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;
    final File file = File(pickedFile.path);
    return file;
  }

  /// function to crop picked image with image_cropper
  static Future<CroppedFile?> cropImage(File file) async {
    final croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      compressQuality: 100,
      maxWidth: 700,
      maxHeight: 700,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Media',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio3x2,
          lockAspectRatio: false,
          showCropGrid: true,
          hideBottomControls: false,
        ),
        IOSUiSettings(
          title: 'Crop Media',
          rotateButtonsHidden: false,
          rotateClockwiseButtonHidden: false,
          resetButtonHidden: false,
        ),
      ],
    );
    return croppedFile;
  }

  ///clear selected image
  static void clearImage() {}

  ///convert selected image to base64
  static Future<String> encodeImageFileToBase64(File file) async {
    final bytes = await file.readAsBytes();
    final base64String = base64Encode(bytes);
    return base64String;
  }
}
