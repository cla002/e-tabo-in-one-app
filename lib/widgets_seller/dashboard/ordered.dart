// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:buyers/providers_seller/order_provider.dart';
import 'package:buyers/services_seller/order_services.dart';
import 'package:buyers/widgets_seller/orders/order_summary_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class DisplayOrdersInDashboard extends StatefulWidget {
  const DisplayOrdersInDashboard({super.key});

  @override
  State<DisplayOrdersInDashboard> createState() =>
      _DisplayOrdersInDashboardState();
}

class _DisplayOrdersInDashboardState extends State<DisplayOrdersInDashboard> {
  final OrderServicesSeller _orderServices = OrderServicesSeller();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var _orderProvider = Provider.of<OrderProviderSeller>(context);
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _orderServices.orders
            .where('seller.sellerId', isEqualTo: user!.uid)
            .where('orderStatus', isEqualTo: 'Ordered')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.size == 0) {
            return const Center(
              child: Column(
                children: [
                  Text('No Orders Available'),
                ],
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Column(
                  children: [
                    OrderSummaryCard(document),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  showMyDialog(title, status, documentId, context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text('Are you Sure you want to $title?'),
          actions: [
            TextButton(
              onPressed: () {
                EasyLoading.show(status: 'Updating Status');
                status == 'Accepted'
                    ? _orderServices
                        .updateOrderStatus(documentId, status)
                        .then((value) {
                        EasyLoading.showSuccess('Updated Successfully');
                      })
                    : _orderServices
                        .updateOrderStatus(documentId, status)
                        .then((value) {
                        EasyLoading.showSuccess('Updated Successfully');
                      });
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
