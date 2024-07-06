import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late ValueNotifier<bool> loading;
  late bool passHide;
  String? _token;

  @override
  void initState() {
    super.initState();
    _getToken();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    loading = ValueNotifier<bool>(false);
    passHide = true;
  }

  Future<void> _getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    setState(() {
      _token = token;
    });
  }

  Future<void> register() async {
    loading.value = true;
    await Future.delayed(const Duration(seconds: 2));
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
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: InputBorder.none,
                      hintText: "E-mail"),
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      border: InputBorder.none,
                      hintText: "Password"),
                )),
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
