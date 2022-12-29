import 'package:burger/core/dependencies/dependencies.dart';
import 'package:burger/core/environment/environment_service.dart';
import 'package:burger/domain/repositories/cart_repository.dart';
import 'package:burger/domain/usecases/find_burger_use_case.dart';
import 'package:burger/presentation/blocs/burger/burger_bloc.dart';
import 'package:burger/presentation/blocs/order/order_bloc.dart';
import 'package:burger/presentation/blocs/user/user_bloc.dart';
import 'package:burger/presentation/cubits/navigation_cubit.dart';
import 'package:burger/presentation/pages/detail/detail_page.dart';
import 'package:burger/presentation/pages/root_page.dart';
import 'package:burger/presentation/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializer(appEnv: AppEnv.develop);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => BurgerBloc(
        findBurgersUseCase: getIt<FindBurgersUseCase>(),
      )..add(
          OnFindBurgers(),
        ),
    ),
    BlocProvider(create: (context) => NavigationCubit()),
    BlocProvider(
        create: (context) => UserBloc(cartRepository: getIt<CartRepository>())),
    BlocProvider(
        create: (context) => OrderBloc(cartRepository: getIt<CartRepository>()))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.themes,
      routes: {
        RootPage.path: (context) => RootPage(),
        DetailPage.path: (context) => DetailPage()
      },
    );
  }
}
