import 'package:firebase_core/firebase_core.dart';
import 'package:firelearn/screens/home_screen.dart';
import 'package:firelearn/screens/register_screen.dart';
import 'package:firelearn/services/auth_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: AuthService().firebaseAuth.authStateChanges(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return RegisterScreen();
            }
          },
        ));
  }
}


/*
Firebase gives option to listen to changes in firebase authentication.
*/