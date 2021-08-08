import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sea_oil/networks/helpers/connectivity_helper.dart';
import 'package:sea_oil/networks/parsers/http_server_response.dart';

import '../../../values/strings.dart' as strings;

class LocationRequestHelper {
  static Future<String> findCoordinateAddress(
      Position position, context) async {
    String placeAddress = '';
    var key = strings.api_key;

    if (!(await ConnectionHelper.hasConnection())) {
      return '';
    }

    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$key';

    // var response = await getRequest(url);

    // if (response != 'failed') {
    //   placeAddress = response['results'][0]['formatted_address'];
    // }

    return placeAddress;
  }
}
