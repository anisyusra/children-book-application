import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_mobile/constants/colors.dart';
import 'dart:io';
import 'package:project_mobile/constants/image_string.dart';
import 'package:project_mobile/constants/sizes.dart';
import 'package:project_mobile/constants/text_strings.dart';
import 'package:project_mobile/screens/homepage/home_screen.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker picker = ImagePicker();

  String _email = '';
  String _password = '';
  String _fullname = '';
  XFile? _profilePic;
  String imageName = "";

  Future<void> _register() async {
  try {
    final UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    );

    // Upload profile picture to Firebase Storage
    if (_profilePic != null) {
      String uploadFileName =
          '${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('users')
          .child(uploadFileName);
      UploadTask uploadTask = reference.putFile(File(_profilePic!.path));
      await uploadTask;

      // Get the download URL of the uploaded image
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();

      // Save user details to Firestore with the profile picture URL
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullname': _fullname,
        'email': _email,
        'password': _password,
        'image': uploadPath, // Save the profile picture URL in Firestore
      });
    } else {
      // Save user details to Firestore without the profile picture URL
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullname': _fullname,
        'email': _email,
        'password': _password,
      }); 
    }

    // Navigate to home page
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  } catch (e) {
    // Handle registration error
    print('Registration error: $e'); // Print error message to console
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Registration Failed'),
          content: const Text('Failed to create an account. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
  Future<void> _pickProfilePic() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profilePic = pickedFile;
        imageName = pickedFile.name.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: tPrimaryColor),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(right: 36.0, left: 36.0, bottom: 36.0, top: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: const AssetImage(tWelcomeScreenImage),
                        height: size.height * 0.15
                      ),
                      const Text(
                        "Get On Board!", 
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          letterSpacing: 0.27,
                          color: Color(0xFF17262A),
                        ),
                      ),
                      const Text(
                        "Create your profile to start your Journey.", 
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: -0.05,
                          color: Color(0xFF253840),
                        )
                      )  ,
                    ],
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: _pickProfilePic,
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100), 
                        child: imageName == "" ? const Image(image: AssetImage("assets/logo/userImage.png")) : Image.file(File(_profilePic!.path)),
                      ),
                    ),
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _fullname = value;
                      });
                    },
                    autofocus: false,
                    showCursor: true,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.account_circle),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Fullname",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                    autofocus: false,
                    showCursor: true,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                    autofocus: false,
                    showCursor: true,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.info_outline,
                          color: Color(0xFF666666),
                          size: 16,
                        ),
                        Text(
                          " Make sure the password is easy",
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontFamily: "Worksan",
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )
                  ),
                  const SizedBox(height: 20),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(15),
                    color: tPrimaryColor,
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                         _register();
                      },
                      child: const Text(
                        tSignup,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18, 
                          color: Color.fromARGB(255, 255, 255, 255), 
                          fontWeight: FontWeight.bold),
                      )
                    ),
                  ),
                  const SizedBox(height: tFormHeight - 20),                  
                  TextButton(
                    onPressed: () { 
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationPage(),
                        ),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        text: 
                        "Already have an account? ",
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: const [
                          TextSpan(
                            text: tLogin, 
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue
                            )
                          )
                        ]
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
