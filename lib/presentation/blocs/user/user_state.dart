part of 'user_bloc.dart';

class UserState extends Equatable {
  final User? user;
  final List<Order> orders;
  final double total;

  const UserState({
    this.user = const User(
      id: "1",
      firstName: "Tokiniaina Eddy",
      lastName: "A",
      email: "e.tokiniaina@gmail.com",
      password: "12345",
      orders: [],
      favorites: [],
    ),
    this.total = 0.0,
    this.orders = const [],
  });

  UserState copyWith({
    User? user,
    List<Order>? orders,
    double? total,
  }) {
    return UserState(
      user: user ?? this.user,
      orders: orders ?? this.orders,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [
        user,
        orders,
        total,
      ];
}
