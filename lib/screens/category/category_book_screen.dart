import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_mobile/constants/colors.dart';
import 'package:project_mobile/models/category.dart';
import 'package:project_mobile/models/ebook.dart';
import 'package:project_mobile/screens/details_book/details_book_screen.dart';

class CategoryBookScreen extends StatefulWidget {
  final Category category;

  const CategoryBookScreen({required this.category});

  @override
  _CategoryBookScreenState createState() => _CategoryBookScreenState();
}

class _CategoryBookScreenState extends State<CategoryBookScreen> {
  List<Ebook> books = [];
  List<Ebook> filteredBooks = [];

  @override
  void initState() {
    super.initState();
    fetchBooks().then((fetchedBooks) {
      setState(() {
        books = fetchedBooks;
        filteredBooks = filterBooksByGenre(widget.category.genre);
      });
    }).catchError((error) {
      print('Failed to fetch books: $error');
    });
  }

  Future<List<Ebook>> fetchBooks() async {
    final response = await http.get(Uri.parse('http://192.168.43.104:3000/books'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) {
        return Ebook(
          id: item['id'] ?? 0,
          title: item['title'] ?? '',
          author: item['author'] ?? '',
          description: item['description'] ?? '',
          image: item['image'] ?? '',
          link: item['link'] ?? '',
          genre: item['genre']?.split(',').map((genre) => genre.trim()).toList() ?? [],
        );
      }).toList();
    } else {
      throw Exception('Failed to fetch books');
    }
  }

  List<Ebook> filterBooksByGenre(String genre) {
    return books.where((book) => book.genre.contains(genre)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tPrimaryColor,
      appBar: AppBar(
        backgroundColor: tPrimaryColor,
        title: Text(widget.category.genre),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 25,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(70),
                      topLeft: Radius.circular(70),
                    ),
                  ),
                  width: double.infinity,
                ),
                OrientationBuilder(builder: (context, orientation) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                    ),
                    itemBuilder: (context, index) => Container(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                authorname: filteredBooks[index].author,
                                bookname: filteredBooks[index].title,
                                imageAddress: filteredBooks[index].image,
                                link: filteredBooks[index].link,
                                description: filteredBooks[index].description,
                              ),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 30),
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 10.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(14.0, 19.0),
                                    ),
                                  ],
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 11,
                                child: SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Hero(
                                    tag: filteredBooks[index].id,
                                    child: Image.network(filteredBooks[index].image),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                      child: Row(
                                        children: [
                                          Text(
                                            filteredBooks[index].title.length > 10
                                                ? '${filteredBooks[index].title.substring(0, 12)}...'
                                                : filteredBooks[index].title,
                                            style: const TextStyle(
                                              color: Color.fromARGB(255, 78, 86, 90),
                                              fontFamily: 'WorkSans',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              letterSpacing: 0.27,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    itemCount: filteredBooks.length,
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
