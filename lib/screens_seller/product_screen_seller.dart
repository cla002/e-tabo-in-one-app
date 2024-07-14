// ignore_for_file: deprecated_member_use

import 'package:buyers/globals/styles.dart';
import 'package:buyers/screens_seller/add_newproduct_screen.dart';
import 'package:buyers/screens_seller/home_screen.dart';
import 'package:flutter/material.dart';

import '../widgets_seller/published_products.dart';
import '../widgets_seller/unpublished_products.dart';

class ProductScreenSeller extends StatefulWidget {
  const ProductScreenSeller({super.key});

  static const String id = 'product-screen';

  @override
  State<ProductScreenSeller> createState() => _ProductScreenSellerState();
}

class _ProductScreenSellerState extends State<ProductScreenSeller> {
  var pressCount = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalStyles.appBarColor,
          centerTitle: true,
          title: const Text(
            'Products',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, HomeScreenSeller.id);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            return false;
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: const Row(
                          children: [
                            Text(
                              'Products',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              maxRadius: 8,
                              child: FittedBox(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    '20',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              GlobalStyles.green,
                            ),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)))),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const AddNewProductSeller(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Padding(
                          padding: EdgeInsets.only(right: 5.0),
                          child: Text(
                            'Add New',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TabBar(
                  indicatorColor: GlobalStyles.green,
                  labelColor: GlobalStyles.green,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(
                      text: 'Un Published',
                    ),
                    Tab(
                      text: 'Published',
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    child: const TabBarView(
                      children: [
                        UnpublishedProducts(),
                        PublishedProducts(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
