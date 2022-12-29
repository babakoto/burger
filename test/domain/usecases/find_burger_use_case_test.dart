import 'package:burger/domain/repositories/burger_repository.dart';
import 'package:burger/domain/usecases/find_burger_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fos/fos.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../constants.dart';
import 'find_burger_use_case_test.mocks.dart';

@GenerateMocks([BurgerRepository])
void main() {
  late MockBurgerRepository mockBurgerRepository;
  late FindBurgersUseCase findBurgers;

  setUp(() {
    mockBurgerRepository = MockBurgerRepository();
    findBurgers = FindBurgersUseCase(burgerRepository: mockBurgerRepository);
  });

  test("FindBurgers should return data from BurgerRepository", () async {
    when(mockBurgerRepository.findBurgers()).thenAnswer(
      (_) async => const SuccessResponse(tBurgers),
    );

    final result = await findBurgers();

    expect(result, const SuccessResponse(tBurgers));
  });
}
