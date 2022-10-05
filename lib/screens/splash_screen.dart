import 'package:flutter/material.dart';
import 'package:pokemon_collector/globals/globals.dart';
import 'package:pokemon_collector/screens/menu/menu_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _myAnimation;

  @override
  void initState() {
    checkPage();
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),

    );
    _myAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.animateTo(1);
  }

  Future<void> checkPage() async {
    await Future.delayed(const Duration(seconds: 3));
    prefs = await SharedPreferences.getInstance();
    Navigator.pushReplacement(
        context, PageRouteBuilder(transitionDuration: const Duration(seconds: 3), pageBuilder: (context, __, ___) => const MenuScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _myAnimation,
          child: Image.network(
            'https://www.pngall.com/wp-content/uploads/13/Pokemon-Logo-PNG-Clipart.png',
            width: MediaQuery.of(context).size.width * 0.7,
          ),
        ),
      ),
    );
  }
}
