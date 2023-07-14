import 'package:http/http.dart' as http;

// Function to recognize handwritten numbers using GPT-3
import 'package:hw2text/env.dart';

class Api {

static Future<String?> recognizeHandwrittenNumber(String imageData) async {
  try {
    // Prepare the API request payload
    final requestBody = {
      'prompt': 'Recognize the handwritten number:',
      'max_tokens': 1,
      'temperature': 0.8,
      'top_p': 1,
      'n': 1,
      'stop': ['\n'],
      'text': imageData,
    };

    // Make the API request to GPT-3
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: requestBody,
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
}

