// ignore_for_file: prefer_const_constructors

import 'package:buyers/globals/styles.dart';
import 'package:buyers/screens_seller/account_screen_seller.dart';
import 'package:buyers/screens_seller/banner_screen.dart';
import 'package:buyers/screens_seller/home_screen.dart';
import 'package:buyers/screens_seller/orders_screen_seller.dart';
import 'package:buyers/screens_seller/product_screen_seller.dart';
import 'package:buyers/utils_seller/logout_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  late User? user;
  DocumentSnapshot? vendorData;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      getVendorData();
    }
  }

  Future<void> getVendorData() async {
    var result = await FirebaseFirestore.instance
        .collection('vendors')
        .doc(user!.uid)
        .get();
    setState(() {
      vendorData = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
//DRAWER HEADER
          UserAccountsDrawerHeader(
            accountName: Text(
              vendorData != null ? vendorData!['shopName'] : 'Store Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(user?.email ?? 'Email'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: vendorData != null &&
                          (vendorData!.data()
                                  as Map<String, dynamic>)['imageUrl'] !=
                              null
                      ? DecorationImage(
                          image: NetworkImage(
                            (vendorData!.data()
                                as Map<String, dynamic>)['imageUrl'] as String,
                          ),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: AssetImage(
                              'lib/images/user.png'), // Provide a fallback image
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: GlobalStyles.appBarColor,
            ),
          ),

//NAVIGATION
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, HomeScreenSeller.id);
            },
            child: ListTile(
              title: Text('Dashboard'),
              leading: Icon(
                Icons.home,
                color: GlobalStyles.green,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ProductScreenSeller.id);
            },
            child: ListTile(
              title: Text('Products'),
              leading: Icon(
                Icons.grain,
                color: GlobalStyles.green,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, BannerScreenSeller.id);
            },
            child: ListTile(
              title: Text('Banners'),
              leading: Icon(
                Icons.image,
                color: GlobalStyles.green,
              ),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.pushNamed(context, OrderScreenSeller.id);
            },
            child: ListTile(
              title: Text('Orders'),
              leading: Icon(
                Icons.view_list_sharp,
                color: GlobalStyles.green,
              ),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ProfileScreenSeller.id);
            },
            child: ListTile(
              title: Text('Account'),
              leading: Icon(
                Icons.settings,
                color: GlobalStyles.green,
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 2,
          ),
          //SIGN OUT
          InkWell(
            onTap: () async {
              logout(context);
            },
            child: const ListTile(
              title: Text(
                'Log Out',
                style: TextStyle(color: Colors.red),
              ),
              leading: Icon(
                Icons.power_settings_new,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
