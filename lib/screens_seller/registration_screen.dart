import 'package:buyers/screens_seller/login_screen.dart';
import 'package:buyers/widgets_seller/image_picker.dart';
import 'package:buyers/widgets_seller/register_form.dart';
import 'package:flutter/material.dart';

class RegistrationScreenSeller extends StatelessWidget {
  const RegistrationScreenSeller({super.key});

  static const String id = 'registration-screenSeller';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const ShopPicCard(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: RegisterForm(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already Have an Account?',
                      style: TextStyle(color: Colors.black54),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreenSeller.id);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
