part of 'burger_bloc.dart';

abstract class BurgerEvent extends Equatable {
  const BurgerEvent();

  @override
  List<Object> get props => [];
}

class OnFindBurgers extends BurgerEvent {}

class OnFindBurgersByRef extends BurgerEvent {
  final String ref;

  const OnFindBurgersByRef({
    required this.ref,
  });

  @override
  List<Object> get props => [ref];
}
