import 'package:flutter/material.dart';
import 'package:restapi/ctrl.dart';
import 'package:restapi/data.dart';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await getData(); // Panggil fungsi fetchData dari ctrl.dart
    setState(() {
      isLoading = false; // Update UI setelah data selesai dimuat
    });
  }

  void deleteItem(int id) {
    deleteData(id, (success) {
      if (success) {
        setState(() {
          data.removeWhere((item) => item['id'] == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil dihapus!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menghapus data!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: data.map((item) {
                return Card(
                  child: ListTile(
                    title: Text(item['title']),
                    subtitle: Text('Post ID: ${item['id']}'),
                    trailing: IconButton(
                      onPressed: () {
                        deleteItem(item['id']);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
