import 'package:app/View/Screens/Home/home_page.dart';
import 'package:app/View/Screens/Login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final storage = const FlutterSecureStorage();
  String name = 'Usuário';
  String token = '';
  late bool loadingCredentials;

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  void _loadCredentials() async {
    setState(() {
      loadingCredentials = true;
    });
    token = await storage.read(key: 'token') ?? '';
    name = await storage.read(key: 'nome') ?? '';

    setState(() {
      loadingCredentials = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loadingCredentials) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF6200EE),
        ),
      );
    } else {
      if (token.isNotEmpty) {
        return const HomePage();
      } else {
        return const LoginPage();
      }
    }
  }
}
