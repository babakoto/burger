import 'package:burger/core/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ServerErrorWidget extends StatefulWidget {
  const ServerErrorWidget({Key? key}) : super(key: key);

  @override
  State<ServerErrorWidget> createState() => _ServerErrorWidgetState();
}

class _ServerErrorWidgetState extends State<ServerErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: Lottie.asset(Assets.jsonServerError),
    );
  }
}
