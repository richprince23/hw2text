import 'dart:convert';

import 'package:http/http.dart' as http;

// Function to recognize handwritten numbers using GPT-3
import 'package:hw2text/env.dart';

class Api {
  static Future<String?> recognizeHandwrittenNumber(String imageData) async {
    try {
      // Prepare the API request payload
      final requestBody = {
        'prompt':
            'Recognize the handwritten number from this image:' + imageData,
        'max_tokens': 1,
        'temperature': 0.8,
        'top_p': 1,
        'n': 1,
        'stop': ['\n'],
        // 'text': imageData,
      };

      final requestBodyJson = json.encode(requestBody);
      // Make the API request to GPT-3
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: requestBodyJson,
      );

      print('Response status: ${response.body}');
      // Extract the recognized number from the response
      // final recognizedNumber = response.body['choices'][0]['text'].trim();

      // return recognizedNumber;
    } catch (error) {
      print('Error recognizing handwritten number: $error');
      return null;
    }
  }

  static Future<String?> recognizeText(String imageData) async {
    var headers = {'apikey': 'K88935604788957'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://api.ocr.space/parse/image'));
    request.fields.addAll({
      'language': 'eng',
      'isOverlayRequired': 'false',
      'iscreatesearchablepdf': 'false',
      'issearchablepdfhidetextlayer': 'false',
      'base64image': 'data:image/jpeg;base64,$imageData'
    });

    request.headers.addAll(headers);

    var response = await request.send();
    final respStr;

    if (response.statusCode == 200) {
      respStr = await response.stream.bytesToString();
    } else {
      respStr = response.reasonPhrase;
    }

    // Use the response data as needed, for example:
    print(respStr);

    // Return the response string or do other processing here.
    return respStr;
  }
}
