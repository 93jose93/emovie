import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
  });

  test('hasConnection devuelve true si hay conexión', () async {
    when(() => mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.wifi]);

    final result =
        await ConnectivityHelperTestable(mockConnectivity).hasConnection();

    expect(result, true);
  });

  test('hasConnection devuelve false si no hay conexión', () async {
    when(() => mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.none]);

    final result =
        await ConnectivityHelperTestable(mockConnectivity).hasConnection();

    expect(result, false);
  });
}

class ConnectivityHelperTestable {
  final Connectivity connectivity;

  ConnectivityHelperTestable(this.connectivity);

  Future<bool> hasConnection() async {
    final results = await connectivity.checkConnectivity();
    return results.isNotEmpty && !results.contains(ConnectivityResult.none);
  }
}
