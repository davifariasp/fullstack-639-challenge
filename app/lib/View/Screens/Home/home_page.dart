import 'package:app/Repositories/weather_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherRepository weatherRepository = WeatherRepository();
  String city = '';
  String region = '';

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
    //pegar os dados climaticos
    getWeather();
    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    setupInteractedMessage();
  }

  getWeather() async {
    final data =
        await weatherRepository.getWeather(lat: -23.5489, lon: -46.6388);

    debugPrint(data.toString());
    setState(() {
      Map<String, dynamic> location = data['location'];
      city = location['name'];
      region = location['region'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge 639'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Welcome to Challenge 639!',
              style: TextStyle(fontSize: 24),
            ),
            Text('$city - $region')
          ],
        ),
      ),
    );
  }
}
