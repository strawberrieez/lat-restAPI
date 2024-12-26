import 'package:flutter/material.dart';
import 'package:restapi/ctrl.dart';
import 'package:restapi/data.dart';

class Update extends StatefulWidget {
  final int index;
  const Update({super.key, required this.index});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  String? _gender;
  String? _status;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: data[widget.index]['name']);
    _emailController = TextEditingController(text: data[widget.index]['email']);
    _gender = data[widget.index]['gender'];
    _status = data[widget.index]['status'];
  }

  void _updateUser() {
    final updatedName = _nameController.text.trim();
    final updatedEmail = _emailController.text.trim();

    if (updatedName.isNotEmpty && updatedEmail.isNotEmpty && _gender != null && _status != null) {
      setState(() {
        isLoading = true;
      });

      final updatedData = {
        'name': updatedName,
        'email': updatedEmail,
        'gender': _gender,
        'status': _status,
      };

      updateData(data[widget.index]['id'], updatedData, (success) {
        setState(() {
          isLoading = false;
        });

        if (success) {
          setState(() {
            data[widget.index] = {
              ...data[widget.index],
              ...updatedData,
            };
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data berhasil diperbarui!')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal memperbarui data!')),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field harus diisi!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            DropdownButtonFormField<String>(
              value: _gender,
              items: const [
                DropdownMenuItem(value: 'male', child: Text('Male')),
                DropdownMenuItem(value: 'female', child: Text('Female')),
              ],
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            DropdownButtonFormField<String>(
              value: _status,
              items: const [
                DropdownMenuItem(value: 'active', child: Text('Active')),
                DropdownMenuItem(value: 'inactive', child: Text('Inactive')),
              ],
              onChanged: (value) {
                setState(() {
                  _status = value;
                });
              },
              decoration: const InputDecoration(labelText: 'Status'),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _updateUser,
                    child: const Text('Update User'),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
