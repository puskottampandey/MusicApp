import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => const HomeScreen())));
    });
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/cool-background.png',
                ),
                fit: BoxFit.cover),
          ),
        ),
        Positioned(
          left: 120,
          right: 120,
          top: 50,
          bottom: 50,
          child: Image.asset(
            'assets/note.png',
          ),
        )
      ],
    );
  }
}
