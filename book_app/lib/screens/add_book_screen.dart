import 'package:book_app/provider/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

class AddBooksScreen extends StatefulWidget {
  const AddBooksScreen({Key? key}) : super(key: key);

  @override
  State<AddBooksScreen> createState() => _AddBooksScreenState();
}

class _AddBooksScreenState extends State<AddBooksScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Book Title'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Book Description'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Book Price'),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                String title = _titleController.text;
                String description = _descriptionController.text;
                int price = int.tryParse(_priceController.text) ?? 0;

                Provider.of<BookProvider>(context, listen: false)
                    .addBooks(title, description, price);
                Navigator.pop(context);
              },
              child: const Text('Add Book'),
            ),
          ],
        ),
      ),
    );
  }
}
