import 'dart:io';

import 'package:app/Repositories/weather_repository.dart';
import 'package:app/Services/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = const FlutterSecureStorage();
  WeatherRepository weatherRepository = WeatherRepository();

  //coordenadas do disp
  double lat = 0.0;
  double lon = 0.0;

  //dados vindos da api
  String city = '';
  String region = '';
  double tempC = 0.0;
  String day = '';
  String conditionText = '';
  String conditionIcon = '';

  late AuthService authService;
  String? _tokenDevice;

  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    debugPrint(message.toString());
  }

  @override
  void initState() {
    super.initState();
    authService = AuthService();
    //pegar os dados climaticos
    getWeather();
    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    setupInteractedMessage();
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

  getLocation() async {
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

    setState(() {
      lat = position.latitude;
      lon = position.longitude;
    });
  }

  getWeather() async {
    //pegar token
    String token = await storage.read(key: 'token') ?? '';
    //pegar coordenadas
    await getLocation();

    final data =
        await weatherRepository.getWeather(token: token, lat: lat, lon: lon);

    Map<String, dynamic> location = data['location'];
    Map<String, dynamic> current = data['current'];

    int isDay = current['is_day'];

    setState(() {
      //dados da cidade
      city = location['name'];
      region = location['region'];

      //dia da semana
      day = handleDayOfWeek(isDay);

      //dados do clima
      tempC = current['temp_c'];
      conditionText = current['condition']['text'];
      conditionIcon = current['condition']['icon'];
    });
  }

  String handleDayOfWeek(int day) {
    switch (day) {
      case 0:
        return 'Domingo';
      case 1:
        return 'Segunda-feira';
      case 2:
        return 'Terça-feira';
      case 3:
        return 'Quarta-feira';
      case 4:
        return 'Quinta-feira';
      case 5:
        return 'Sexta-feira';
      case 6:
        return 'Sábado';
      default:
        return '';
    }
  }

  void handleLogout() async {
    await _getToken();
    debugPrint('Logout');
    await storage.delete(key: 'name');
    await storage.delete(key: 'token');
    debugPrint("token " + _tokenDevice!);
    final response = await authService.logout(_tokenDevice!);
    debugPrint(response['message']);

    Modular.to.navigate('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge 639'),
        backgroundColor: const Color(0xFF6200EE),
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: handleLogout, icon: const Icon(Icons.logout))
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$city - $region'),
            Text(day),
            conditionIcon.isNotEmpty
                ? Image.network('https:$conditionIcon')
                : const CircularProgressIndicator(
                    color: Color(0xFF6200EE),
                  ),
            Text('$tempC °C'),
            Text(conditionText),
          ],
        ),
      ),
    );
  }
}
