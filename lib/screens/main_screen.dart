import 'package:flutter/material.dart';
import 'package:pokemon_collector/globals/globals.dart';
import 'package:pokemon_collector/globals/helpers/size_config.dart';
import 'package:pokemon_collector/screens/splash_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      child: Scaffold(
        backgroundColor: mainColor,
        body: const SplashScreen(),
      ),
    );
  }
}
