import 'dart:async';
import 'package:buyers/globals/styles.dart';
import 'package:buyers/screens_buyer/main_screen_buyer.dart';
import 'package:buyers/screens_buyer/welcome_screen_buyer.dart';
import 'package:buyers/screens_seller/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String id = 'splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animationController.forward();
    Timer(const Duration(seconds: 6), _checkUser);
  }

  Future<void> _checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userRole = prefs.getString('user_role');

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, WelcomeScreen.id);
      } else {
        if (userRole == 'seller') {
          Navigator.pushReplacementNamed(context, HomeScreenSeller.id);
        } else {
          Navigator.pushReplacementNamed(context, MainScreenBuyer.id);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [GlobalStyles.green, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.bounceOut,
                )),
                child: Hero(
                  tag: 'E-Tabo',
                  child: Image.asset(
                    'lib/images/logo.png',
                    height: GlobalStyles.screenHeight(context) * 0.15,
                  ),
                ),
              ),
              FadeTransition(
                opacity:
                    Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeInOut,
                )),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'E-Tabo',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 9, 61, 11),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
