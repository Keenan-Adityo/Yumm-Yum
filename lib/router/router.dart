import 'package:get/get.dart';
import 'package:yumm_yum/pages/admin/add_food_page.dart';
import 'package:yumm_yum/pages/admin/admin_login_page.dart';
import 'package:yumm_yum/pages/admin/admin_page.dart';
import 'package:yumm_yum/pages/bottomnav.dart';
import 'package:yumm_yum/pages/login.dart';
import 'package:yumm_yum/pages/signup.dart';

class appRoutes {
  static final routes = [
    GetPage(
      name: '/',
      page: () => LogIn(),
    ),
    GetPage(
      name: '/bottomNav',
      page: () => BottomNav(),
    ),
    GetPage(
      name: '/signup',
      page: () => SignUp(),
    ),
    GetPage(
      name: '/adminlogin',
      page: () => AdminLoginPage(),
    ),
    GetPage(
      name: '/adminhome',
      page: () => AdminPage(),
    ),
    GetPage(
      name: '/adminaddfood',
      page: () => AddFoodPage(),
    ),
  ];
}
