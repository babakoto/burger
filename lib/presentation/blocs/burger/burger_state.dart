part of 'burger_bloc.dart';

enum BurgerStatus {
  init,
  loading,
  failure,
  success,
}

extension BurgerStatusExtension on BurgerStatus {
  bool get isInit => this == BurgerStatus.init;

  bool get isLoading => this == BurgerStatus.loading;

  bool get isFailure => this == BurgerStatus.failure;

  bool get isSuccess => this == BurgerStatus.success;
}

class BurgerState extends Equatable {
  final List<Burger> burgers;
  final Burger? selected;
  final BurgerStatus burgerStatus;
  final Failure? failure;

  const BurgerState({
    this.selected,
    this.burgers = const [],
    this.burgerStatus = BurgerStatus.init,
    this.failure,
  });

  @override
  List<Object?> get props => [
        burgers,
        burgerStatus,
        failure,
        selected,
      ];

  BurgerState copyWith({
    List<Burger>? burgers,
    Burger? selected,
    BurgerStatus? burgerStatus,
    Failure? failure,
  }) {
    return BurgerState(
      burgers: burgers ?? this.burgers,
      selected: selected ?? this.selected,
      burgerStatus: burgerStatus ?? this.burgerStatus,
      failure: failure ?? this.failure,
    );
  }
}
