import 'package:buyers/globals/styles.dart';
import 'package:buyers/widgets_seller/dashboard/earnings.dart';
import 'package:buyers/widgets_seller/dashboard/store_products.dart';
import 'package:buyers/widgets_seller/dashboard/total_orders.dart';
import 'package:flutter/material.dart';

class ProductInventory extends StatefulWidget {
  const ProductInventory({super.key});

  @override
  State<ProductInventory> createState() => _ProductInventoryState();
}

class _ProductInventoryState extends State<ProductInventory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: GlobalStyles.screenWidth(context),
        height: 600,
        child: const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Earnings(),
              SizedBox(
                height: 10,
              ),
              TotalProductOrders(),
              SizedBox(
                height: 10,
              ),
              NumberofYourStoreProducts(),
            ],
          ),
        ));
  }
}