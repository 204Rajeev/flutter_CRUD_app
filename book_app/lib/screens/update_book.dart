import 'package:book_app/provider/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateBook extends StatefulWidget {
  const UpdateBook({super.key, required this.id});
  final id;

  @override
  State<UpdateBook> createState() => _UpdateBookState();
}

class _UpdateBookState extends State<UpdateBook> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Book'),
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
                    .updateBook(widget.id, title, description, price);
                Navigator.pop(context);
              },
              child: const Text('Update Book'),
            ),
          ],
        ),
      ),
    );
  }
}
