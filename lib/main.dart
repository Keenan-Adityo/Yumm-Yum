import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yumm_yum/pages/signup.dart'; // Sesuaikan dengan path file SignUp.dart Anda
import 'package:yumm_yum/pages/login.dart'; // Sesuaikan dengan path file LogIn.dart Anda
import 'package:yumm_yum/pages/bottomnav.dart'; // Sesuaikan dengan path file BottomNav.dart Anda

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
