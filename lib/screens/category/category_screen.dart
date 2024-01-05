import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';
import '../../models/category.dart';
import '../homepage/home_screen.dart';
import 'category_book_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('category');

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
    future: _reference.get() as Future<QuerySnapshot<Map<String, dynamic>>>?,
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return const Center(
          child: Text('Something went wrong'),
        );
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return const Center(
          child: Text("No data available"),
        );
      }

      QuerySnapshot querySnapshot = snapshot.data!;
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
      List<Category> categories = documents
          .map((e) => Category(
            id: e['id'],
            genre: e['genre']))
          .toList();

      return Stack(
        children: <Widget>[
          _getBody(context, categories),
        ],
      );
    },
  ),
);
  }

  Widget _getBody(BuildContext context, List<Category> categories) {
  categories.sort((a, b) => a.genre.compareTo(b.genre)); // Sort categories in ascending order by genre

  var size = MediaQuery.of(context).size;
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: tPrimaryColor,
      elevation: 1,
      centerTitle: true,
      title: const Text(
        "Category",
        style: TextStyle(
          fontFamily: 'WorkSans',
          fontWeight: FontWeight.bold,
          fontSize: 22,
          letterSpacing: 0.27,
          color: Colors.white,
        ),
      ),
      leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                icon: const Icon(Icons.home),
                iconSize: 25,
                color: Colors.white,
              ),
    ),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      width: double.infinity,
                      height: size.height * 0.82,
                      child: ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              _navigateToCategoryBooks(
                                context, categories[index]);
                            },
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 9,
                                  left: 5,
                                  child: Container(
                                    height: 38,
                                    width: 5,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                      color: tPrimaryColor,
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 4.0,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8))),
                                  margin: const EdgeInsets.only(
                                      left: 10.0, bottom: 10.0, right: 10.0, top: 10.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 8.0,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Row(
                                            children: <Widget>[
                                              const SizedBox(
                                                width: 16.0,
                                              ),
                                              Text(
                                                categories[index].genre,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
}

  void _navigateToCategoryBooks(BuildContext context, Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryBookScreen(category: category),
      ),
    );
  }
}
