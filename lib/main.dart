import 'package:agustin_walter_aluxion/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Aluxion());

class Aluxion extends StatelessWidget {
  const Aluxion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aluxion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Museo Sans',
      ),
      home: const HomeScreen(),
    );
  }
}
