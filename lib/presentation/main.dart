import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/presentation/screen/dashboard_of_fragments.dart';
import 'package:shop/presentation/screen/login/bloc/login_bloc.dart';
import 'package:shop/presentation/screen/login/login_screen.dart';

import '../data/repo/auth_repository.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDrekY9chy4cU0Hi-pap5yhwk3f6iPABAA',
    appId: '1:567171076805:android:66c20b70465657d4c116ac',
    messagingSenderId: '567171076805',
    projectId: 'onlineshop-c1903',
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  var isLogin = false;
  var auth = FirebaseAuth.instance;

  checkIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  void initState() {
    checkIfLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => LoginBloc(
                      authRepositoryImpl: AuthRepositoryImpl(
                    FirebaseAuth.instance,
                    FirebaseFirestore.instance,
                  ))),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Clothes App',
          theme: ThemeData(
            primarySwatch: Colors.yellow,
          ),
          home: FutureBuilder(
            builder: (context, dataSnapShot) {
              return isLogin
                  ? const DashboardOfFragments()
                  : const LoginScreen();
            },
          ),
        ));
  }
}
