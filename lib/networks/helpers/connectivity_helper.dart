import 'package:connectivity/connectivity.dart';

class ConnectionHelper {
  static ConnectivityResult _connectivityResult = ConnectivityResult.none;

  static Future _connect() async =>
      _connectivityResult = await Connectivity().checkConnectivity();

  /// The hasConnection() function checks if the device currently has access to the Internet

  static Future<bool> hasConnection() async {
    await _connect();

    if (_connectivityResult == ConnectivityResult.mobile) return true;
    if (_connectivityResult == ConnectivityResult.wifi) return true;
    return false;
  }

  static Stream<ConnectivityResult> connectionListener() =>
      Connectivity().onConnectivityChanged;
}
