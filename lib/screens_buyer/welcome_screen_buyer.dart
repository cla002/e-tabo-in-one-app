// // ignore_for_file: unused_local_variable

// import 'package:buyers/globals/styles.dart';
// import 'package:buyers/providers_buyer/auth_provider.dart';
// import 'package:buyers/screens_buyer/onboarding_screen.dart';
// import 'package:buyers/screens_buyer/update_after_login.dart';
// import 'package:buyers/screens_seller/login_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({super.key});

//   static const String id = 'welcome-screen';

//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }

// class _WelcomeScreenState extends State<WelcomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<MyAuthProviderBuyer>(context);
//     bool validPhoneNumber = false;
//     final phoneNumberController = TextEditingController();

//     void showBottomSheet(context) {
//       showModalBottomSheet(
//         context: context,
//         builder: (context) => StatefulBuilder(
//           builder: (context, StateSetter myState) {
//             return Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     const Text(
//                       'Login',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     TextField(
//                       decoration: const InputDecoration(
//                         prefixText: '+63',
//                         labelText: 'Enter Your Phone Number',
//                       ),
//                       autofocus: true,
//                       keyboardType: TextInputType.phone,
//                       maxLength: 10,
//                       controller: phoneNumberController,
//                       onChanged: (value) {
//                         if (value.length == 10) {
//                           myState(
//                             () {
//                               validPhoneNumber = true;
//                             },
//                           );
//                         } else {
//                           myState(
//                             () {
//                               validPhoneNumber = false;
//                             },
//                           );
//                         }
//                       },
//                     ),
//                     const SizedBox(
//                       height: 12,
//                     ),
//                     AbsorbPointer(
//                       absorbing: validPhoneNumber ? false : true,
//                       child: FilledButton(
//                         onPressed: () {
//                           myState(() {
//                             auth.loading = true;
//                           });
//                           String number = '+63${phoneNumberController.text}';
//                           auth.verifyPhone(
//                               context: context,
//                               number: number,
//                               latitude: null,
//                               longitude: null,
//                               address: null);
//                         },
//                         style: ButtonStyle(
//                           minimumSize: MaterialStatePropertyAll(
//                               Size(GlobalStyles.screenWidth(context), 40)),
//                           backgroundColor: validPhoneNumber
//                               ? MaterialStatePropertyAll(Colors.purple.shade900)
//                               : const MaterialStatePropertyAll(Colors.grey),
//                           shape: const MaterialStatePropertyAll(
//                             BeveledRectangleBorder(side: BorderSide.none),
//                           ),
//                         ),
//                         child: auth.loading
//                             ? const CircularProgressIndicator(
//                                 valueColor:
//                                     AlwaysStoppedAnimation<Color>(Colors.white),
//                               )
//                             : Text(validPhoneNumber
//                                 ? 'Continue'
//                                 : 'Input Your Number'),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 const Expanded(
//                   child: OnBoardingScreen(),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.pushNamed(context, LoginScreenSeller.id);
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         alignment: Alignment.center,
//                         decoration: const BoxDecoration(color: Colors.green),
//                         width: GlobalStyles.screenWidth(context) - 40,
//                         height: 40,
//                         child: const Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Become A Seller',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     signInWithGoogle(context);
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(border: Border.all(width: 1)),
//                         width: GlobalStyles.screenWidth(context) - 40,
//                         height: 40,
//                         child: Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image.asset('lib/images/google.png'),
//                               const SizedBox(width: 8),
//                               const Text(
//                                 'Continue with Google',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         showBottomSheet(context);
//                       },
//                       child: const Text(
//                         'Login with Phone Number',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   signInWithGoogle(BuildContext context) async {
//     GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//     AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
//     UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);

//     User? user = userCredential.user;

//     // Save user data to Firestore collection
//     if (user != null) {
//       // Firestore reference
//       final usersRef = FirebaseFirestore.instance.collection('users');

//       // Add user data to Firestore
//       await usersRef.doc(user.uid).set({
//         'email': user.email,
//         'displayName': user.displayName,
//         'number': user.phoneNumber,
//         'profilePicture': user.photoURL,
//         // Add any other fields you want to save
//       });

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) => const UpdateProfileAfterLoginScreen()),
//       );
//     }

//     print('User ID: ${user?.uid}');
//     print('Email: ${user?.email}');
//     print('Display Name: ${user?.displayName}');
//     print('Phone Number: ${user?.phoneNumber}');
//     print('Photo URL: ${user?.photoURL}');
//   }
// }

import 'package:buyers/globals/styles.dart';
import 'package:buyers/providers_buyer/auth_provider.dart';
import 'package:buyers/screens_buyer/onboarding_screen.dart';
import 'package:buyers/screens_buyer/update_after_login.dart';
import 'package:buyers/screens_seller/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const String id = 'welcome-screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<MyAuthProviderBuyer>(context);
    bool validPhoneNumber = false;
    final phoneNumberController = TextEditingController();

    void showBottomSheet(context) {
      showModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, StateSetter myState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    decoration: const InputDecoration(
                      prefixText: '+63',
                      labelText: 'Enter Your Phone Number',
                    ),
                    autofocus: true,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    controller: phoneNumberController,
                    onChanged: (value) {
                      myState(() {
                        validPhoneNumber = value.length == 10;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  AbsorbPointer(
                    absorbing: !validPhoneNumber,
                    child: FilledButton(
                      onPressed: () {
                        myState(() {
                          auth.loading = true;
                        });
                        String number = '+63${phoneNumberController.text}';
                        auth
                            .verifyPhone(
                          context: context,
                          number: number,
                          latitude: null,
                          longitude: null,
                          address: null,
                        )
                            .then((_) async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('user_role', 'buyer');
                        });
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(GlobalStyles.screenWidth(context), 40),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          validPhoneNumber
                              ? Colors.purple.shade900
                              : Colors.grey,
                        ),
                        shape: MaterialStateProperty.all(
                          BeveledRectangleBorder(side: BorderSide.none),
                        ),
                      ),
                      child: auth.loading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              validPhoneNumber
                                  ? 'Continue'
                                  : 'Input Your Number',
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Column(
              children: [
                const Expanded(child: OnBoardingScreen()),
                const SizedBox(height: 20),
                _buildSellerButton(context),
                const SizedBox(height: 5),
                _buildGoogleSignInButton(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        showBottomSheet(context);
                      },
                      child: const Text(
                        'Login with Phone Number',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSellerButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_role', 'seller');
        Navigator.pushNamed(context, LoginScreenSeller.id);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: Colors.green),
            width: GlobalStyles.screenWidth(context) - 40,
            height: 40,
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Become A Seller',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleSignInButton(BuildContext context) {
    return InkWell(
      onTap: () {
        signInWithGoogle(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            width: GlobalStyles.screenWidth(context) - 40,
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('lib/images/google.png'),
                  const SizedBox(width: 8),
                  const Text(
                    'Continue with Google',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        final usersRef = FirebaseFirestore.instance.collection('users');

        await usersRef.doc(user.uid).set({
          'email': user.email,
          'displayName': user.displayName,
          'number': user.phoneNumber,
          'profilePicture': user.photoURL,
        });

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_role', 'buyer');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UpdateProfileAfterLoginScreen(),
          ),
        );
      }
    } catch (e) {
      // Handle error
      print('Google Sign-In failed: $e');
    }
  }
}
