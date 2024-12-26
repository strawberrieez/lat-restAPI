import 'package:flutter/material.dart';
import 'package:restapi/ctrl.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  bool isLoading = false;

  void _createPost() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final gender = genderController.text.trim().toLowerCase();
    final status = statusController.text.trim().toLowerCase();

    if (name.isEmpty || email.isEmpty || gender.isEmpty || status.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field harus diisi!')),
      );
      return;
    }

    if (gender != 'male' && gender != 'female') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gender harus "male" atau "female"!')),
      );
      return;
    }

    if (status != 'active' && status != 'inactive') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Status harus "active" atau "inactive"!')),
      );
      return;
    }

    final newData = {
      'name': name,
      'email': email,
      'gender': gender,
      'status': status,
    };

    setState(() {
      isLoading = true;
    });

    createData(newData, (success, responseData) {
      setState(() {
        isLoading = false;
      });

      if (success && responseData != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil dibuat!')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal membuat data!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: genderController,
              decoration: const InputDecoration(
                labelText: 'Gender (male/female)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(
                labelText: 'Status (active/inactive)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : _createPost,
              child: isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Create User'),
            ),
          ],
        ),
      ),
    );
  }
}
