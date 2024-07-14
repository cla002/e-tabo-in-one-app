// ignore_for_file: prefer_const_constructors

import 'package:buyers/providers_buyer/auth_provider.dart';
import 'package:buyers/providers_buyer/cart_provider.dart';
import 'package:buyers/providers_buyer/location_provider.dart';
import 'package:buyers/providers_buyer/order_provider.dart';
import 'package:buyers/providers_buyer/store_provider.dart';
import 'package:buyers/providers_seller/auth_provider.dart';
import 'package:buyers/providers_seller/order_provider.dart';
import 'package:buyers/screens_buyer/after_login_screen.dart';
import 'package:buyers/screens_buyer/home_screen_buyer.dart';
import 'package:buyers/screens_buyer/main_screen_buyer.dart';
import 'package:buyers/screens_buyer/map_screen_buyer.dart';
import 'package:buyers/screens_buyer/my_orders_buyer.dart';
import 'package:buyers/screens_buyer/product_list_screen_buyer.dart';
import 'package:buyers/screens_buyer/profile_screen_buyer.dart';
import 'package:buyers/screens_buyer/splash_screen.dart';
import 'package:buyers/screens_buyer/update_after_login.dart';
import 'package:buyers/screens_buyer/update_profile_screen_buyer.dart';
import 'package:buyers/screens_buyer/welcome_screen_buyer.dart';
import 'package:buyers/screens_seller/account_screen_seller.dart';
import 'package:buyers/screens_seller/add_newproduct_screen.dart';
import 'package:buyers/screens_seller/banner_screen.dart';
import 'package:buyers/screens_seller/coupon_screen.dart';
import 'package:buyers/screens_seller/home_screen.dart';
import 'package:buyers/screens_seller/login_screen.dart';
import 'package:buyers/screens_seller/orders_screen_seller.dart';
import 'package:buyers/screens_seller/product_screen_seller.dart';
import 'package:buyers/screens_seller/registration_screen.dart';
import 'package:buyers/screens_seller/reset_password_screen.dart';
import 'package:buyers/screens_seller/waiting_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MyAuthProviderBuyer(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProviderBuyer(),
        ),
        ChangeNotifierProvider(
          create: (_) => StoreProviderBuyer(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProviderBuyer(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProviderBuyer(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProviderSeller(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProviderSeller(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple.shade900,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        //BUYER ROUTES
        HomeScreen.id: (context) => HomeScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SplashScreen.id: (conext) => SplashScreen(),
        MapScreen.id: (context) => MapScreen(),
        MainScreenBuyer.id: (context) => MainScreenBuyer(),
        ProductListScreen.id: (context) => ProductListScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        UpdateProfile.id: (context) => UpdateProfile(),
        SetYourLocationScreen.id: (context) => SetYourLocationScreen(),
        MyOrders.id: (context) => MyOrders(),
        UpdateProfileAfterLoginScreen.id: (context) =>
            UpdateProfileAfterLoginScreen(),

        //SELLER ROUTES
        LoginScreenSeller.id: (context) => LoginScreenSeller(),
        RegistrationScreenSeller.id: (context) => RegistrationScreenSeller(),
        WaitingScreenSeller.id: (context) => WaitingScreenSeller(),
        ProfileScreenSeller.id: (context) => ProfileScreenSeller(),
        // AddEditCouponScreenSeller.id: (context) => AddEditCouponScreenSeller(document: )
        AddNewProductSeller.id: (context) => AddNewProductSeller(),
        BannerScreenSeller.id: (context) => BannerScreenSeller(),
        CouponScreenSeller.id: (context) => CouponScreenSeller(),
        HomeScreenSeller.id: (context) => HomeScreenSeller(),
        OrderScreenSeller.id: (context) => OrderScreenSeller(),
        ProductScreenSeller.id: (context) => ProductScreenSeller(),
        ResetPasswordScreenSeller.id: (context) => ResetPasswordScreenSeller(),
      },
      builder: EasyLoading.init(),
    );
  }
}
