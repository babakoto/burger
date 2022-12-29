part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final int currentPage;

  const NavigationState({
    this.currentPage = 0,
  });

  @override
  List<Object> get props => [currentPage];

  NavigationState copyWith({
    int? currentPage,
  }) {
    return NavigationState(
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
