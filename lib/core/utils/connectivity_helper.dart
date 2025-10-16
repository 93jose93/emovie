import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  static Future<bool> hasConnection() async {
    final connectivity = Connectivity();
    final results = await connectivity.checkConnectivity();

    // ✅ Si la lista no está vacía y ninguno es 'none', hay conexión
    return results.isNotEmpty && !results.contains(ConnectivityResult.none);
  }
}
