import 'dart:io';

import 'package:app/Services/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';

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
  late AuthService authService;
  final storage = const FlutterSecureStorage();

  //coordenadas do disp
  double lat = 0.0;
  double lon = 0.0;
  String? _tokenDevice;

  @override
  void initState() {
    super.initState();
    authService = AuthService();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    loading = ValueNotifier<bool>(false);
    passHide = true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    loading.dispose();
    super.dispose();
  }

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    bool permissionLocAllowed = await Geolocator.isLocationServiceEnabled();

    if (!permissionLocAllowed) {
      return Future.error('Permissão de localização não permitida');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Permissão de localização não permitida');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permissão de localização não permitida');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    debugPrint('lat: $position.latitude, lon: $position.longitude');

    setState(() {
      lat = position.latitude;
      lon = position.longitude;
    });
  }

  Future<void> _getToken() async {
    late String? token;

    if (Platform.isIOS) {
      token = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      token = await FirebaseMessaging.instance.getToken();
    }

    debugPrint('tokenDevice: $token');

    setState(() {
      _tokenDevice = token;
    });
  }

  Future<void> login() async {
    
    Map<String, dynamic> response = await authService.login(
        _emailController.text,
        _passwordController.text,
        lat,
        lon,
        _tokenDevice!);

    if (response['token'] != null) {
      await storage.write(key: 'name', value: response['name']);
      await storage.write(key: 'token', value: response['token']);

      Modular.to.navigate('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao logar'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    
  }

  Future<void> loginWithDetails() async {
    loading.value = true;

    try {
      // Obtém a localização do usuário
      await getLocation();

      // Obtém o token do dispositivo
      await _getToken();

      // Executa o login com os detalhes obtidos
      await login();
    } catch (e) {
      // Tratamento de erros, se necessário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro: ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
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
                          icon: Icon(passHide
                              ? Icons.visibility
                              : Icons.visibility_off),
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
                onPressed: () async => await loginWithDetails(),
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
                    onTap: () => {Modular.to.navigate('/register')},
                    child: const Text(
                      "Cadastre-se",
                      style: TextStyle(
                          color: Color(0xFF6200EE),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
