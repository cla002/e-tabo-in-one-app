import 'package:buyers/screens_seller/login_screen.dart';
import 'package:flutter/material.dart';

class WaitingScreenSeller extends StatelessWidget {
  const WaitingScreenSeller({super.key});

  static const String id = 'waiting-screenSeller';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'PLEASE WAIT FOR THE ADMIN TO ACTIVATE YOUR ACCOUNT',
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreenSeller.id);
            },
            child: const Text(
              'Close',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
