import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/constants/colors.dart';
import 'package:project_mobile/constants/image_string.dart';
import 'package:project_mobile/constants/text_theme.dart';
import 'package:project_mobile/models/user_model.dart';
import 'package:project_mobile/screens/category/category_screen.dart';
import 'package:project_mobile/screens/profile/profile_screen.dart';
import '../authentication/login/login_page.dart';
import '../quiz/quiz_main.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
      .collection("users")
      .doc(user?.uid)
      .get()
      .then((value) {
        loggedInUser = UserModel.fromJson(value.data()!);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(194, 193, 225, 1.0),
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen()
              ),
            );
          }, 
          icon: const Icon(Icons.settings),
          color: nearlyBlack,
        ),
        actions: [
          IconButton(
            onPressed: (){
              logout(context);
            }, 
            icon: const Icon(Icons.logout_rounded),
            color: nearlyBlack,
          )
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 0),
          width: size.width,
          color: const Color.fromRGBO(194, 193, 225, 1.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image(
                image: const AssetImage(tHomePageImage),
                height: size.height * 0.45
              ),
              const Text(
                'WELCOME,',
                style: display1,
              ),
              Text(
                "${loggedInUser.fullname}",
                style: const TextStyle( // h5 -> headline
                  fontFamily: fontName,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  letterSpacing: 0.27,
                  color: nearlyBlack,
                ),
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoriesScreen()
                        ),
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 5),                        
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(tBookImage),
                        )
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizMain()
                        ),
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 5),
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(tGameImage),
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ]
          ),
        ),
      )
    );
  }
  
  Future<void> logout(BuildContext context) async {
      await FirebaseAuth.instance.signOut();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
  }
}