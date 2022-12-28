import 'package:burger/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';

main() {
  runApp(const Burger());
}

class Burger extends StatelessWidget {
  const Burger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
