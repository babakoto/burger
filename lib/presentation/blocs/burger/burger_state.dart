part of 'burger_bloc.dart';

abstract class BurgerState extends Equatable {
  const BurgerState();
}

class BurgerInitial extends BurgerState {
  @override
  List<Object> get props => [];
}
