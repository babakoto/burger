import 'package:burger/presentation/cubits/navigation_cubit.dart';
import 'package:burger/presentation/pages/cart/cart_page.dart';
import 'package:burger/presentation/pages/home/home_page.dart';
import 'package:burger/presentation/themes/app_themes.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootPage extends StatefulWidget {
  static const path = "/";
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        return CurvedNavigationBar(
          backgroundColor: AppThemes.backgroundColor,
          index: state.currentPage,
          color: AppThemes.red,
          items: const <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.shopping_cart, size: 30),
            Icon(Icons.settings, size: 30),
          ],
          onTap: (index) {
            context.read<NavigationCubit>().onChanged(index);
          },
        );
      }),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.currentPage,
            children: const [HomePage(), CartPage(), SizedBox()],
          );
        },
      ),
    );
  }
}
