import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleMapScreen extends StatefulWidget {
  const StyleGoogleMapScreen({super.key});

  @override
  State<StyleGoogleMapScreen> createState() => _StyleGoogleMapScreenState();
}

class _StyleGoogleMapScreenState extends State<StyleGoogleMapScreen> {
  /*
  
  */
  String mapTheme = '';
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(29.3981, 71.6908),
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString(
      'assets/mapTheme/silver_theme.json',
    )
        .then((value) {
      mapTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Maps Theme'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  _controller.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString(
                      'assets/mapTheme/silver_theme.json',
                    )
                        .then((str) {
                      mapTheme = str;
                    });
                  });
                },
                child: const Text('Silver'),
              ),
              PopupMenuItem(
                onTap: () {
                  _controller.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString(
                      'assets/mapTheme/retro_theme.json',
                    )
                        .then((str) {
                      mapTheme = str;
                    });
                  });
                },
                child: const Text('Retro'),
              ),
              PopupMenuItem(
                onTap: () {
                  _controller.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString(
                      'assets/mapTheme/dark_theme.json',
                    )
                        .then((str) {
                      mapTheme = str;
                    });
                  });
                },
                child: const Text('Dark'),
              ),
              PopupMenuItem(
                onTap: () {
                  _controller.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString(
                      'assets/mapTheme/night_theme.json',
                    )
                        .then((str) {
                      mapTheme = str;
                    });
                  });
                },
                child: const Text('Night'),
              ),
              PopupMenuItem(
                onTap: () {
                  _controller.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString(
                      'assets/mapTheme/aubergine_theme.json',
                    )
                        .then((str) {
                      mapTheme = str;
                    });
                  });
                },
                child: const Text('Aubergine'),
              ),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(mapTheme);
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
