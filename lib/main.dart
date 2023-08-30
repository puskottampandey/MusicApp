import 'package:flutter/material.dart';
import 'package:musicapp/controller/contoller.dart';
import 'package:musicapp/views/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SongsProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        ));
  }
}
