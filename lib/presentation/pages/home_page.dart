import 'package:flutter/material.dart';

import 'package:geo_snap/config/route_constants.dart';
import 'package:geo_snap/core/services/navigation_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GeoSnap')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(
                  const Size(double.infinity, 50),
                ),
              ),
              onPressed: () async {
                NavigationService().pushNamed(RouteNames.camera);
              },
              child: Text('Request Camera'),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(
                  const Size(double.infinity, 50),
                ),
              ),
              onPressed: () {
                NavigationService().pushNamed(RouteNames.gallery);
              },
              child: Text('Go to Gallery'),
            ),
          ),
        ],
      ),
    );
  }
}
