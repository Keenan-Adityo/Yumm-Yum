import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yumm_yum/pages/admin/admin_login_page.dart';
import 'package:yumm_yum/pages/admin/admin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  debugPrint('Firebase initialized successfully');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AdminLoginPage(),
    );
  }
}
