import 'package:book_app/provider/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookTile extends StatelessWidget {
  const BookTile(
      {super.key,
      this.length,
      this.title,
      this.description,
      this.price,
      this.id});

  final length;
  final title;
  final description;
  final price;
  final id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Column(
          children: [
            Text(description),
            Text(
              price.toString(),
            ),
          ],
        ),
        tileColor: Colors.amber[100],
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            Provider.of<BookProvider>(context, listen: false).deleteBook(id);
          },
        ),
      ),
    );
  }
}
