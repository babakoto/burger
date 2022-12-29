import 'package:burger/data/repositories/burger_repository_imp.dart';
import 'package:burger/data/services/burgers/burger_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fos/fos.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../constants.dart';
import 'burger_repository_imp_test.mocks.dart';

@GenerateMocks([BurgerService])
void main() {
  late MockBurgerService mockBurgerService;
  late BurgerRepositoryImp burgerRepositoryImp;

  setUp(() {
    mockBurgerService = MockBurgerService();
    burgerRepositoryImp = BurgerRepositoryImp(burgerService: mockBurgerService);
  });

  test("Should return List<Burger> when success", () async {
    when(mockBurgerService.findBurgers()).thenAnswer((_) async => tBurgers);

    final result = await burgerRepositoryImp.findBurgers();

    expect(result, const SuccessResponse(tBurgers));
  });

  test("Should return ServerFailure when throw ServerException", () async {
    when(mockBurgerService.findBurgers())
        .thenThrow(const ServerException(message: tErrorMessageServer));

    final result = await burgerRepositoryImp.findBurgers();
    expect(
      result,
      const FailureResponse(
        ServerFailure(message: tErrorMessageServer),
      ),
    );
  });
  test("Should return NetworkFailure when throw NetworkException", () async {
    when(mockBurgerService.findBurgers())
        .thenThrow(const NetworkException(message: tErrorMessageNetwork));

    final result = await burgerRepositoryImp.findBurgers();
    expect(
      result,
      const FailureResponse(
        NetworkFailure(message: tErrorMessageNetwork),
      ),
    );
  });
  test("Should return UnauthorizedFailure when throw UnauthorizedException",
      () async {
    when(mockBurgerService.findBurgers()).thenThrow(
        const UnauthorizedException(message: tErrorMessageUnauthorized));

    final result = await burgerRepositoryImp.findBurgers();
    expect(
      result,
      const FailureResponse(
        UnauthorizedFailure(message: tErrorMessageUnauthorized),
      ),
    );
  });
}
