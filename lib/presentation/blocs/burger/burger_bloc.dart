import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:burger/domain/entities/burger.dart';
import 'package:burger/domain/usecases/find_burger_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:fos/fos.dart';

part 'burger_event.dart';
part 'burger_state.dart';

class BurgerBloc extends Bloc<BurgerEvent, BurgerState> {
  final FindBurgersUseCase findBurgersUseCase;

  BurgerBloc({required this.findBurgersUseCase}) : super(const BurgerState()) {
    on<OnFindBurgers>(_onFindBurgers);
    on<OnFindBurgersByRef>(_onFindBurgersByRef);
  }

  FutureOr<void> _onFindBurgers(
      OnFindBurgers event, Emitter<BurgerState> emit) async {
    emit(state.copyWith(burgerStatus: BurgerStatus.loading));

    final result = await findBurgersUseCase();

    result.on(
      (failure) {
        emit(state.copyWith(
          failure: failure,
          burgerStatus: BurgerStatus.failure,
        ));
      },
      (success) {
        emit(state.copyWith(
          failure: null,
          burgerStatus: BurgerStatus.success,
          burgers: success,
        ));
      },
    );
  }

  FutureOr<void> _onFindBurgersByRef(
      OnFindBurgersByRef event, Emitter<BurgerState> emit) async {
    final burger =
        state.burgers.firstWhere((element) => element.ref == event.ref);
    emit(state.copyWith(selected: burger));
  }
}
