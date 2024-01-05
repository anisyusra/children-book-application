import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_mobile/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference<Map<String, dynamic>> booksCollection =
    FirebaseFirestore.instance.collection('book(test)');

Map<String, String> bookLinks = {};

class DetailsPage extends StatefulWidget {
  final String imageAddress;
  final String bookname;
  final String authorname;
  final String link;
  final String description;
  final String? id;

  DetailsPage({
    required this.authorname,
    required this.bookname,
    required this.imageAddress,
    required this.link,
    required this.description,
    this.id,
  });

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<String> linkBook = [];
  String longestDescription = '';


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: Colors.amber,
      body:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                    height: size.height * 0.075,
                    width: size.width,
                    //color: Colors.red,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Material(
                              // color: Colors.white.withOpacity(0),
                              child: InkWell(
                                onTap: () => Navigator.pop(context),
                                borderRadius: BorderRadius.circular(
                                    constraints.maxHeight * 0.4),
                                splashColor: Colors.white,
                                child: Container(
                                  padding:
                                      EdgeInsets.all(constraints.maxHeight * 0.18),
                                  //color: Colors.black,
                                  height: constraints.maxHeight * 0.8,
                                  width: constraints.maxWidth * 0.15,
                                  child: const FittedBox(
                                      child: Icon(
                                    Icons.arrow_back_ios,
                                    color: tPrimaryColor,
                                  )),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.19,
                            ),
                            const Text(
                              "Details Book",
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 0.27,
                                color: Color(0xFF17262A),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height:size.height * 0.9,
                    width: size.width,
                    child: Stack(
                      children:[
                        Positioned(
                        child: Container(
                          height: size.height * 0.5,
                          width: size.width * 0.95,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 253, 249),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 233, 233, 233).withOpacity(0.5), //color of shadow
                                  spreadRadius: 5, //spread radius
                                  blurRadius: 5, // blur radius
                                  offset: Offset(2, 2),)
                            ]
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  height: size.height * 0.35,
                                  width: size.width * 0.45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(size.width * 0.05),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromARGB(255, 233, 233, 233).withOpacity(0.5), //color of shadow
                                          spreadRadius: 5, //spread radius
                                          blurRadius: 5, // blur radius
                                          offset: Offset(2, 2),)
                                    ],
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(widget.imageAddress)
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: size.width * 0.33),
                                height: size.height * 0.025,
                                width: size.width*0.7,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    widget.bookname,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromRGBO(66, 66, 86, 1)),
                                  )
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: size.width * 0.33, vertical: size.width * 0.009),
                                height: size.height * 0.03,
                                width: size.width,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    widget.authorname,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                    ),
                                  )
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                        // Positioned(
                        //   child: Container(
                        //     height: size.height * 0.5,
                        //     width: size.width * 0.95,
                        //     decoration: BoxDecoration(
                        //       color:const Color.fromARGB(255, 255, 253, 249),
                        //       borderRadius: const BorderRadius.all(Radius.circular(10)),
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: const Color.fromARGB(255, 233, 233, 233).withOpacity(0.5), //color of shadow
                        //           spreadRadius: 5, //spread radius
                        //           blurRadius: 5, // blur radius
                        //           offset: const Offset(2, 2),
                        //         )
                        //       ]
                        //     ),
                        //     child: Column(
                        //       children: [
                        //         Padding(
                        //           padding: const EdgeInsets.only(top: 50),
                        //           child: DropShadowImage(
                        //             offset: Offset(5,5),
                        //             scale: 1,
                        //             blurRadius: 10,
                        //             borderRadius: 10,
                        //             image: Image.network(widget.imageAddress,
                        //             width: 180,),
                        //           )
                        //         ),
                        //         const SizedBox(height: 15),
                        //         Container(
                        //           padding: EdgeInsets.symmetric(horizontal: size.width * 0.33),
                        //           height: size.height * 0.020,
                        //           width: size.width*0.7,
                        //           child: FittedBox(
                        //             fit: BoxFit.fitHeight,
                        //             child: Text(
                        //               widget.bookname,
                        //               style: GoogleFonts.lato(
                        //                 fontWeight: FontWeight.bold,
                        //                 color: const Color.fromRGBO(66, 66, 86, 1)),
                        //             )
                        //           ),
                        //         ),
                        //         Container(
                        //           padding: EdgeInsets.symmetric(horizontal: size.width * 0.33, vertical: size.width * 0.009),
                        //           height: size.height * 0.03,
                        //           width: size.width,
                        //           child: FittedBox(
                        //             fit: BoxFit.fitHeight,
                        //             child: Text(
                        //               widget.authorname,
                        //               style: GoogleFonts.lato(
                        //                 fontWeight: FontWeight.bold,
                        //                 color: Colors.grey
                        //               ),
                        //             )
                        //           ),
                        //         ),
                        //       ],
                        //     )
                        //   ),
                        // ),
                        Positioned(
                          top: 340,
                          left: 10,
                          child: SizedBox(
                            height: size.height * 0.6,
                            width: size.width,
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top:20, right: 240),
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                      fontFamily: 'WorkSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      letterSpacing: 0.27,
                                      color: darkerText,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:11, right: 60),
                                  child: Text(
                                    textAlign: TextAlign.justify,
                                    widget.description,
                                      style: const TextStyle(
                                        fontFamily: 'WorkSans',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: darkerText,
                                      ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0, right: 65),
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(15),
                                    color: tPrimaryColor,
                                    child: MaterialButton(
                                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                      minWidth: size.width*0.8,
                                      onPressed: () {
                                         _launchURL(widget.link);
                                      },
                                      child: const Text(
                                        "Read Here",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18, 
                                          color: Color.fromARGB(255, 255, 255, 255), 
                                          fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                              ],
                            )
                          ),                          
                        ),
                      ]
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}