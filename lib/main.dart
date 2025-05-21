import 'package:appone/splash_screen.dart';
import 'package:appone/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  fontFamily: 'Roboto',
  useMaterial3: true,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.deepPurpleAccent,
  fontFamily: 'Roboto',
  useMaterial3: true,
);
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      home: const SplashScreen(),
    );
  }
}
