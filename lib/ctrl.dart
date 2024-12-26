import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restapi/data.dart';

Future<void> getData() async {
  try {
    var url = Uri.parse('https://gorest.co.in/public/v2/users');
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer babc358ca5c037f0693b5bb17e9e8436db1b21a682c2c92ef1ad61f1c4a4819b',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      data = json.decode(response.body);
    } else {
      data = [];
      debugPrint('Failed to load data. Status: ${response.statusCode}');
    }
  } catch (e) {
    data = [];
    debugPrint('Error loading data: $e');
  }
}

Future<void> deleteData(int id, Function(bool) onDeleteComplete) async {
  try {
    var url = Uri.parse('https://gorest.co.in/public/v2/users');
    var response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer babc358ca5c037f0693b5bb17e9e8436db1b21a682c2c92ef1ad61f1c4a4819b',
        'Content-Type': 'application/json',
      },
    );

    debugPrint('Request headers: ${response.request?.headers}');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 204) {
      onDeleteComplete(true);
    } else {
      onDeleteComplete(false);
    }
  } catch (e) {
    debugPrint('Error deleting data: $e');
    onDeleteComplete(false);
  }
}

Future<void> createData(Map<String, dynamic> newData, Function(bool, Map<String, dynamic>?) onCreateComplete) async {
  try {
    var url = Uri.parse('https://gorest.co.in/public/v2/users');
    var response = await http.post(
      url,
      body: json.encode(newData),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer babc358ca5c037f0693b5bb17e9e8436db1b21a682c2c92ef1ad61f1c4a4819b',
      },
    );

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      // debugPrint('Response status: ${response.statusCode}');
      // debugPrint('Response body: ${response.body}');
      // debugPrint('Headers: ${response.headers}');
      onCreateComplete(true, responseData);
    } else {
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      onCreateComplete(false, null);
    }
  } catch (e) {
    debugPrint('Error: $e');
    onCreateComplete(false, null);
  }
}

Future<void> updateData(
  int id,
  Map<String, dynamic> updatedData,
  Function(bool) onUpdateComplete,
) async {
  try {
    var url = Uri.parse('https://gorest.co.in/public/v2/users');
    var response = await http.put(
      url,
      body: json.encode(updatedData),
      headers: {
        'Authorization': 'Bearer babc358ca5c037f0693b5bb17e9e8436db1b21a682c2c92ef1ad61f1c4a4819b',
        'Content-Type': 'application/json',
      },
    );

    debugPrint('Request headers: ${response.request?.headers}');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 404) {
      onUpdateComplete(true);
      debugPrint('Update berhasil.');
      debugPrint('Response status: ${response.statusCode}');
    } else {
      onUpdateComplete(false);
      debugPrint('Update gagal. Status: ${response.statusCode}');
      debugPrint('Response status: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error updating data: $e');
    onUpdateComplete(false);
  }
}
