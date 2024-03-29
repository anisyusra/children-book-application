import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:project_mobile/constants/colors.dart';
import 'package:project_mobile/constants/image_string.dart';
import 'package:project_mobile/constants/sizes.dart';
import 'package:project_mobile/constants/text_strings.dart';

import 'profile_update.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? userName = '';
    String? userEmail = '';
    String? userProfileImage;

    if (user != null) {
      return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Text('User data not found');
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;

          if (user.providerData.first.providerId == 'password') {
            // User logged in with email and password
            userName = userData['fullname'] ?? 'Unknown User';
            userEmail = userData['email'] ?? 'Unknown User';
            userProfileImage = userData['image'] ?? null;
          } else if (user.providerData.first.providerId == 'google.com') {
            // User logged in with Google authentication
            userName = user.displayName ?? user.email ?? 'Unknown User';
            userEmail = user.email;
            userProfileImage = user.photoURL;
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: tPrimaryColor,
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(LineAwesomeIcons.angle_left),
              ),
              title: const Text(
                tProfile,
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 0.27,
                  color: Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(tDefaultSize),
                child: Column(
                  children: [
                    // -- IMAGE
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: userProfileImage != null
                              ? NetworkImage(userProfileImage!)
                              : const AssetImage(tProfileImage)
                                  as ImageProvider<Object>?,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: tPrimaryColor,
                            ),
                            child: const Icon(
                              LineAwesomeIcons.alternate_pencil,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // -- BUTTON
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UpdateProfileScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tPrimaryColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(),
                    const SizedBox(height: 10),

                    // Detail of the user
                    TextFormField(
                      initialValue: userName,
                      enabled: false,
                      style: TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person_outline_rounded),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: userEmail,
                      enabled: false,
                      style: TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Container(
        child: Text('Error'),
      );
    }
  }
}