import 'package:flutter/material.dart';
import 'package:restapi/create.dart';
import 'package:restapi/ctrl.dart';
import 'package:restapi/data.dart';
import 'package:restapi/update.dart';

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
    await getData();
    setState(() {
      isLoading = false;
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Create()),
          );
          if (result == true) {
            _loadData();
          }
        },
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: data.map((item) {
                int index = data.indexOf(item);
                return Card(
                  child: ListTile(
                    title: Text(item['name']),
                    subtitle: Text('Post ID: ${item['id']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Update(index: index),
                              ),
                            );
                          },
                          icon: const Icon(Icons.update),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteItem(item['id']);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
