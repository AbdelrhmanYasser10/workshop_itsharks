import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

import '../shared/styles/app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? userLocation;
  MapController controller = MapController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.kPrimaryColor,
        onPressed: () async {
          PermissionStatus status = await Permission.location.request();
          if (status == PermissionStatus.granted) {
            /* go on to get user location*/
            Position userPose = await Geolocator.getCurrentPosition();
            userLocation = LatLng(userPose.latitude, userPose.longitude);
            controller.move(userLocation!, 17.2);
            setState(() {});
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("You not allowing to get your location")),
            );
          }
        },
        child: Icon(Icons.my_location, color: Colors.white),
      ),
      body: FlutterMap(
        mapController: controller,
        options: MapOptions(
          initialCenter: LatLng(30.033333, 31.233334),
          // Center the map over London
          initialZoom: 9.2,
        ),
        children: [
          TileLayer(
            // Bring your own tiles
            urlTemplate:
                'https://api.maptiler.com/maps/openstreetmap/{z}/{x}/{y}.jpg?key=WB1imKRisyiBa9agZNux',
            // For demonstration only
            userAgentPackageName:
                'com.example.gemini_clone_app', // Add your app identifier
            // And many more recommended properties!
          ),
          userLocation != null
              ? MarkerLayer(
                markers: [
                  Marker(
                    point: userLocation!,
                    child: Icon(Icons.location_on, color: Colors.red , size: controller.camera.zoom * 2.1,),
                  ),
                ],
              )
              : const SizedBox(),
        ],
      ),
    );
  }
}
