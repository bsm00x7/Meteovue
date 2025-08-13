import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomeController with ChangeNotifier {
  Future<void> getCurrentLoaction() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint("Loaction is not enabled");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }
      if (LocationPermission.deniedForever == permission) {
        debugPrint("Permisson in Forever denided");
        return;
      }
      Position position = await Geolocator.getCurrentPosition(
    
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String address = "Could not determine address.";
      if (placemarks.isNotEmpty) {
        // Construct a readable address string from the placemark.
        Placemark place = placemarks[0];
        address = '${place.locality}, ${place.country}';
      }
      debugPrint('address : $address \n \n \n  ');
      debugPrint(
        'Latitude : ${position.latitude} \n Longitude ${position.longitude}',
      );
    } catch (e) {
      debugPrint("Error getlocator");
    }
  }
}
