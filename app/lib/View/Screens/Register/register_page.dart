import 'package:app/Services/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'dart:io' show Platform;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late ValueNotifier<bool> loading;
  late bool passHide;
  late AuthService authService;
  String? _token;

  @override
  void initState() {
    super.initState();
    _getToken();
    authService = AuthService();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    loading = ValueNotifier<bool>(false);
    passHide = true;
  }

  Future<void> _getToken() async {
    late String? token;

    if (Platform.isIOS) {
      await Future.delayed(const Duration(seconds: 2));
      token = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      token = await FirebaseMessaging.instance.getToken();
    }

    debugPrint('tokenDevice: $token');

    setState(() {
      _token = token;
    });
  }

  Future<void> register() async {
    loading.value = true;
    Map<String, dynamic> response = await authService.register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _token!);

    if (response['token'] != null) {
      Modular.to.navigate('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao logar'),
          duration: Duration(seconds: 2),
        ),
      );
    }
    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      border: InputBorder.none,
                      hintText: "Name"),
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: InputBorder.none,
                      hintText: "E-mail"),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _passwordController,
                          obscureText: passHide,
                          decoration: const InputDecoration(
                              labelText: 'Password',
                              border: InputBorder.none,
                              hintText: "Password"),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            passHide = !passHide;
                          });
                        },
                        iconSize: 16,
                        icon: Icon(
                            passHide ? Icons.visibility : Icons.visibility_off),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () async => await register(),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF6200EE),
                foregroundColor: Colors.white,
                fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: AnimatedBuilder(
                animation: loading,
                builder: (context, _) {
                  return loading.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                      : const Text("Entrar", style: TextStyle(fontSize: 16));
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Já possui uma conta? "),
                InkWell(
                  onTap: () => Modular.to.navigate('/'),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Color(0xFF6200EE), fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
