import 'package:flutter/material.dart';
import 'pages/signup_page.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter App',
      home: SignupPage(),
    );
  }
}