import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late ValueNotifier<bool> loading;
  late bool passHide;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    loading = ValueNotifier<bool>(false);
    passHide = true;
  }

  Future<void> login() async {
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
              onPressed: () async => await login(),
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
                const Text("Não possui uma conta? "),
                InkWell(
                  onTap: () => {
                    Modular.to.navigate('/register')
                  },
                  child: const Text(
                    "Cadastre-se",
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
