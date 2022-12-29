import 'package:burger/data/services/burgers/burger_service_imp.dart';
import 'package:burger/data/services/networks/network_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fos/errors/server_exception.dart';
import 'package:fos/errors/unauthorized_exception.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../constants.dart';
import 'burger_service_imp_test.mocks.dart';

@GenerateMocks([NetworkService, DioAdapter])
void main() {
  late MockNetworkService mockNetworkService;
  late MockDioAdapter mockDioAdapter;
  late BurgerServiceImp burgerServiceImp;
  late Dio dio;

  setUp(() {
    dio = Dio();
    mockDioAdapter = MockDioAdapter();
    mockNetworkService = MockNetworkService();
    dio.httpClientAdapter = mockDioAdapter;
    burgerServiceImp = BurgerServiceImp(
      dio: dio,
      networkService: mockNetworkService,
    );
  });

  group("When online", () {
    setUp(() {
      when(mockNetworkService.hasConnection).thenAnswer((_) async => true);
    });

    test("Should return List<Burger> when Success", () async {
      final response = ResponseBody.fromString(tBurgersString, 200, headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType]
      });

      when(mockDioAdapter.fetch(any, any, any)).thenAnswer(
        (_) async => response,
      );

      final result = await burgerServiceImp.findBurgers();

      expect(result, tBurgers);
    });

    test("Should throw ServerException when status 500", () async {
      final response = ResponseBody.fromString("{}", 500, headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType]
      });

      when(mockDioAdapter.fetch(any, any, any)).thenAnswer(
        (_) async => response,
      );

      final result = burgerServiceImp.findBurgers;

      expect(() => result(), throwsA(const ServerException()));
    });

    test("Should throw UnauthorizedException when status 403", () async {
      final response = ResponseBody.fromString("{}", 403, headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType]
      });

      when(mockDioAdapter.fetch(any, any, any)).thenAnswer(
        (_) async => response,
      );

      final result = burgerServiceImp.findBurgers;

      expect(
        () => result(),
        throwsA(
          const UnauthorizedException(),
        ),
      );
    });
  });
}
