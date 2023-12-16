import 'dart:convert';
import 'package:book_app/models/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class BookProvider with ChangeNotifier {
  final List<Book> _books = [];
  bool isLoading = true;

  List<Book> get books {
    return _books;
  }

  Future<void> loadBooks() async {
    try {
      final response = await http.get(Uri.parse('$apiBaseUrl/books'));
      print(response.body);
      var jsonData = jsonDecode(response.body) as List<dynamic>;
      for (int i = 0; i < jsonData.length; i++) {
        var book = jsonData[i] as Map<String, dynamic>;
        _books.add(
          Book(
              id: book['id'],
              title: book['title'],
              description: book['description'],
              price: book['price']),
        );
      }
      print(jsonData);
      isLoading = false;
    } catch (err) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> addBooks(String title, String description, int price) async {
    isLoading = true;

    try {
      var bookData = {
        'title': title,
        'description': description,
        'price': price,
      };

      var jsonData = jsonEncode(bookData);

      final response = await http.post(
        Uri.parse('$apiBaseUrl/books'),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      print(response.body);

      if (response.statusCode == 200) {
        _books.add(
          Book(
            title: title,
            description: description,
            price: price,
          ),
        );
        isLoading = false;
        notifyListeners();
      } else {
        print('Error adding book: ${response.statusCode}');
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> deleteBook(int id) async {
    isLoading = true;
    try {
      final response = await http.delete(
        Uri.parse('$apiBaseUrl/books/$id'),
      );

      if (response.statusCode == 200) {
        print('Book with ID $id deleted successfully');
      } else {
        print('Error deleting book with ID $id: ${response.statusCode}');
      }
      _books.removeAt(_books.indexWhere((book) => book.id == id));
      isLoading = false;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updateBook(
      int id, String title, String description, int price) async {
    isLoading = true;
    try {
      var updatedBookData = {
        'title': title,
        'description': description,
        'price': price,
      };

      var jsonData = jsonEncode(updatedBookData);

      final response = await http.put(
        Uri.parse('$apiBaseUrl/books/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );
      _books[_books.indexWhere((book) => book.id == id)].price = price;
      _books[_books.indexWhere((book) => book.id == id)].description =
          description;
      _books[_books.indexWhere((book) => book.id == id)].title = title;
      notifyListeners();
      isLoading = false;

      if (response.statusCode == 200) {
        print('Book with ID $id updated successfully');
      } else {
        print('Error updating book with ID $id: ${response.statusCode}');
      }
    } catch (err) {
      print('Error: $err');
    }
  }
}
