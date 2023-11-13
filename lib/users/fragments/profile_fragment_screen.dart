import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/users/model/user.dart';
import 'package:shop/users/userPreferences/auth_repository.dart';
import '../authentication/login_screen.dart';

class ProfileFragmentScreen extends StatelessWidget {
  AuthRepositoryImpl repositoryImpl =
      AuthRepositoryImpl(FirebaseAuth.instance, FirebaseFirestore.instance);

  Widget userInfoItemProfile(IconData iconData, String userData) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black),
          color: Colors.grey,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            userData,
            style: const TextStyle(
              fontSize: 15,
            ),
          )
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<UserModel>(
      future: repositoryImpl.profile(),
      builder: (context, snapshot) {
        return ListView(
          padding: const EdgeInsets.all(32),
          children: [
            const Center(
              child: Icon(
                Icons.person_pin,
                size: 240,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            userInfoItemProfile(Icons.person, snapshot.data?.user_name ?? ''),
            const SizedBox(
              height: 14,
            ),
            userInfoItemProfile(Icons.email, snapshot.data?.user_email ?? ''),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: Material(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(32),
                  child: TextButton(
                    child: const Text(
                      "Sign Out",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    onPressed: () async {
                      await repositoryImpl.logOut();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                    },
                  ),
                ),
              ),
            )
          ],
        );
      },
    ));
  }
}
