import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yumm_yum/pages/signup.dart';
import 'package:yumm_yum/pages/login.dart';
import 'package:yumm_yum/pages/bottomnav.dart';

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
      title: 'Yumm Yum',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignUp(), // Menampilkan SignUp sebagai halaman awal
      routes: {
        '/login': (context) => LogIn(), // Rute ke halaman login
        '/bottomNav': (context) => BottomNav(), // Rute ke halaman BottomNav
      },
    );
  }
}
