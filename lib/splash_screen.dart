import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences_practice/home_screen.dart';
import 'package:shared_preferences_practice/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_practice/student_screen.dart';
import 'package:shared_preferences_practice/teacher_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin();
  }
    void isLogin() async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      bool isLogin = sp.getBool('isLogin') ?? false;
      String userType = sp.getString('userType') ?? '';
      if (isLogin) {
        if (userType == 'student') {
          Timer(const Duration(seconds: 3), () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => StudentScreen()));
          });
        } else if ( userType == 'teacher'){
          Timer(const Duration(seconds: 3), () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TeacherScreen()));
          });
        } else {
          Timer(const Duration(seconds: 3), () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          });
        }
      }
      else {
        Timer(const Duration(seconds: 3), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        });
      }
    }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Image(
          height: double.infinity,
          fit: BoxFit.fitHeight,
          image: NetworkImage(
              'https://images.pexels.com/photos/1633525/pexels-photo-1633525.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')),
    );
  }
}
