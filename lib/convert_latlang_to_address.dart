import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLangToAddress extends StatefulWidget {
  const ConvertLatLangToAddress({super.key});

  @override
  State<ConvertLatLangToAddress> createState() =>
      _ConvertLatLangToAddressState();
}

class _ConvertLatLangToAddressState extends State<ConvertLatLangToAddress> {
  String myAdreess = '';
  String yourAdreess = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text(myAdreess)),
          const SizedBox(height: 20),
          Center(child: Text(yourAdreess)),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              List<Placemark> placemarks =
                  await placemarkFromCoordinates(29.3981, 71.6908);

              List<Location> locations =
                  await locationFromAddress("Gronausestraat 710, Enschede");

              setState(() {
                myAdreess =
                    "My Address is : ${placemarks.reversed.last.country.toString()} + ${placemarks.reversed.last.locality.toString()}";
              });
              yourAdreess =
                  "Your Address is : ${locations.last.longitude.toString()}  : ${locations.last.latitude.toString()}";
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.pink,
                ),
                child: const Center(
                  child: Text(
                    'Convert',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
