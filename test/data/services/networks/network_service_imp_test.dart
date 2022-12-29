import 'package:burger/data/services/networks/network_service_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_service_imp_test.mocks.dart';

@GenerateMocks([InternetConnectionCheckerPlus])
void main() {
  late MockInternetConnectionCheckerPlus mockInternetConnectionCheckerPlus;
  late NetworkServiceImp networkServiceImp;

  setUp(() {
    mockInternetConnectionCheckerPlus = MockInternetConnectionCheckerPlus();
    networkServiceImp = NetworkServiceImp(
      internetConnectionCheckerPlus: mockInternetConnectionCheckerPlus,
    );
  });

  test("Should return true when online", () async {
    when(mockInternetConnectionCheckerPlus.hasConnection).thenAnswer(
      (_) async => true,
    );

    final result = await networkServiceImp.hasConnection;

    expect(result, true);
  });

  test("Should return false when offline", () async {
    when(mockInternetConnectionCheckerPlus.hasConnection).thenAnswer(
      (_) async => false,
    );

    final result = await networkServiceImp.hasConnection;

    expect(result, false);
  });
}
