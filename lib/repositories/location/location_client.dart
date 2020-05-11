
import 'package:location/location.dart';

class LocationClient {
  Location location = Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  Future<LocationData> getCurrentLocation() async {

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print("GPS service is disabled.");
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print("App not get enough permission.(to GPS)");
      }
    }
    try{
      _locationData = await location.getLocation();
      if(_locationData != null){
        return _locationData;
      }
    }catch(e){
      print('could not get location: $e');
    }
  }
}