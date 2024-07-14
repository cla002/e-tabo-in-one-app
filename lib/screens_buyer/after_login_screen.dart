import 'package:buyers/globals/styles.dart';
import 'package:buyers/providers_buyer/location_provider.dart';
import 'package:buyers/screens_buyer/map_screen_buyer.dart';
import 'package:buyers/services_buyer/location_permission.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetYourLocationScreen extends StatefulWidget {
  static const String id = 'set-location-screen';

  const SetYourLocationScreen({super.key});

  @override
  State<SetYourLocationScreen> createState() => _SetYourLocationScreenState();
}

class _SetYourLocationScreenState extends State<SetYourLocationScreen> {
  @override
  Widget build(BuildContext context) {
    final locationData =
        Provider.of<LocationProviderBuyer>(context, listen: false);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/cantilan-map.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FilledButton(
                style: ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(
                      Size(GlobalStyles.screenWidth(context), 40)),
                  shape: const MaterialStatePropertyAll(
                    BeveledRectangleBorder(side: BorderSide.none),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    locationData.loading = true;
                  });
                  print("Set location button pressed");
                  bool permissionGranted =
                      await locationData.getCurrentPosition();
                  if (permissionGranted && locationData.permissionAllowed) {
                    Navigator.pushReplacementNamed(context, MapScreen.id);
                    setState(() {
                      locationData.loading = false;
                    });
                  } else {
                    setState(() {
                      locationData.loading = false;
                    });
                    // Handle the case where permission is denied
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const LocationPermissionDialog();
                      },
                    );
                  }
                },
                child: locationData.loading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text('Set Your Location'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
