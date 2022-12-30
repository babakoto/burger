import 'package:burger/presentation/exports.dart';
import 'package:flutter/material.dart';

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
