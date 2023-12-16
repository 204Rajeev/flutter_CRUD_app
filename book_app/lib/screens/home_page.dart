import 'package:book_app/provider/book_provider.dart';
import 'package:book_app/screens/add_book_screen.dart';
import 'package:book_app/screens/update_book.dart';
import 'package:book_app/widgets/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    loadBooks();
  }

  void loadBooks() async {
    try {
      await Provider.of<BookProvider>(context, listen: false).loadBooks();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use the BookProvider directly without using Consumer
    final bookProvider = Provider.of<BookProvider>(context, listen: true);
    return Provider.of<BookProvider>(context, listen: false).isLoading
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Book App'),
            ),
            body: Center(
              child: bookProvider.books.isEmpty
                  ? const Text('No books available.')
                  : ListView.builder(
                      itemCount: bookProvider.books.length,
                      itemBuilder: (context, idx) {
                        return GestureDetector(
                          child: BookTile(
                            title: bookProvider.books[idx].title,
                            description: bookProvider.books[idx].description,
                            price: bookProvider.books[idx].price,
                            id: bookProvider.books[idx].id,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UpdateBook(id: bookProvider.books[idx].id),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddBooksScreen()),
                );
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
  }
}
