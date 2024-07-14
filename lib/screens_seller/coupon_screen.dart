// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:buyers/globals/styles.dart';
import 'package:buyers/screens_seller/add_edit_coupon_screen_seller.dart';
import 'package:buyers/services_seller/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CouponScreenSeller extends StatefulWidget {
  const CouponScreenSeller({Key? key}) : super(key: key);

  static const String id = 'coupon-screen';

  @override
  _CouponScreenSellerState createState() => _CouponScreenSellerState();
}

class _CouponScreenSellerState extends State<CouponScreenSeller> {
  var pressCount = 0;

  @override
  Widget build(BuildContext context) {
    FirebaseServicesSeller services = FirebaseServicesSeller();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalStyles.appBarColor,
        centerTitle: true,
        title: const Text(
          'Coupons',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
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
        child: Scaffold(
          body: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: services.coupons
                  .where('sellerId', isEqualTo: services.user!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No Coupon Added'),
                  );
                }

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AddEditCouponScreenSeller(
                                  document: null,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Add New Coupon',
                            style: TextStyle(
                              color: GlobalStyles.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: FittedBox(
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text('Title'),
                            ),
                            DataColumn(
                              label: Text('Rate'),
                            ),
                            DataColumn(
                              label: Text('Status'),
                            ),
                            DataColumn(
                              label: Text('Info'),
                            ),
                            DataColumn(
                              label: Text('Info'),
                            ),
                          ],
                          rows: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            var data = document.data() as Map<String, dynamic>;
                            var date = data['expiry'].toDate();
                            var expiry =
                                DateFormat.yMMMd().add_jm().format(date);
                            return DataRow(
                              cells: [
                                DataCell(Text(data['title'].toString())),
                                DataCell(Text(data['discountRate'].toString())),
                                DataCell(Text(
                                    data['active'] ? 'Active' : 'Inactive')),
                                DataCell(Text(data['details'].toString())),
                                DataCell(
                                  IconButton(
                                    icon:
                                        const Icon(Icons.info_outline_rounded),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddEditCouponScreenSeller(
                                            document: document,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
