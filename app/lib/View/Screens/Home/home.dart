import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge 639'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Challenge 639!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
