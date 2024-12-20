import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Get extends StatelessWidget {
  const Get({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            var url = Uri.https('jsonplaceholder.typicode.com', '/posts');
            var response = await http.get(url);
            debugPrint('Response status: ${response.statusCode}');
            debugPrint('Response body: ${response.body}');
          },
          child: Text('get'),
        ),
      ),
    );
  }
}