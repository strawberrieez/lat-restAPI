import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restapi/data.dart';

Future<void> getData() async {
  try {
    var url = Uri.https('jsonplaceholder.typicode.com', '/posts');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      data = json.decode(response.body);
    } else {
      data = [];
    }
  } catch (e) {
    data = [];
  }
}

Future<void> deleteData(int id, Function(bool) onDeleteComplete) async {
  try {
    var url = Uri.https('jsonplaceholder.typicode.com', '/posts/$id');
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      onDeleteComplete(true);
    } else {
      onDeleteComplete(false);
    }
  } catch (e) {
    onDeleteComplete(false);
  }
}
