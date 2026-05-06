import 'package:flutter/material.dart';
import 'landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ASTI Labs',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        fontFamily: 'Poppins',
      ),
      home: LandingPage(),
    );
  }
}