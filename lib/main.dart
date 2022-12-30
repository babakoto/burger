import 'package:burger/core/exports.dart';
import 'package:burger/domain/exports.dart';
import 'package:burger/presentation/blocs/exports.dart';
import 'package:burger/presentation/cubits/navigation_cubit.dart';
import 'package:burger/presentation/routes/app_routes.dart';
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
      routes: AppRoute.routes,
    );
  }
}
