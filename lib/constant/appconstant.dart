


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppConstant {
  static final String username = "username";
  static final String userid = "userid";
  static final String fcmtoken = "fcmtoken";
  static final String headertoken = "headertoken";
  static final String useremail = "useremail";
  static final String userphone = "userphone";
  static final String userotp = "userotp";
  static final String userphonecode = "userphonecode";
  static final String userimage = "userimage";
  static final String imagePath = "imagePath";
  static final String isLoggedIn = "isLoggedIn";
  static final String stripekey = "stripekey";
  static final String rozarkey = "rozarkey";
  static final String fullImage="fullImage";
  static double currentlat = 0;
  static double currentlong = 0;

  static final String singlesalonName = "singlesalonName";
  static final String salonAddress = "salonAddress";
  static final String salonRating = "salonRating";
  static final String salonImage = "salonImage";

  static final String salonName = "salonName";
  static final String role = "role";

  static final String sharedName="sharedName";
  static final String sharedUrl="SharedUrl";
  static final String sharedImage="sharedImage";

  static Future<String> cuttentlocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places.isNotEmpty) {
      final Placemark place = places.first;
      print(place.locality);
      print(place.thoroughfare);
      final currentAddress = place.thoroughfare! + "," + place.locality!;

      AppConstant.currentlong = position.longitude;
      AppConstant.currentlat = position.latitude;

      return currentAddress;
    }
    return "No address available";
  }

  static Future<LatLng?> currentlatlong() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places.isNotEmpty) {
      final Placemark place = places.first;
      print(place.locality);
      print(place.thoroughfare);

      return LatLng(position.latitude, position.longitude);
    }
    return null;
  }

  static Future<String> getDistance(double lat, double long) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places.isNotEmpty && places.isNotEmpty) {
      double salonLat = lat;
      double salonLong = long;
      assert(salonLat is double);
      assert(salonLong is double);
      double distanceInMeters = Geolocator.distanceBetween(
          position.latitude, position.longitude, salonLat, salonLong);

      double distanceinkm = distanceInMeters / 1000;

      print("current_distanceInMeters:$distanceInMeters");
      print("current_distanceinkm:$distanceinkm");

      String str = distanceinkm.toString();

      var distance12 = str.split('.');

      String distance = distance12[0];
      print("km123:$distance");
      return distance;
    } else {
      return "0";
    }
  }


  static Future<bool> checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      // ToastMessage.toastMessage("No Internet Connection");
      return false;
    }
  }

}
