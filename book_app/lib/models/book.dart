class Book {
  final id;
  String title;
  String description;
  int price;
  final cover;
  Book(
      {this.id,
      required this.title,
      required this.description,
      required this.price,
      this.cover});
}
