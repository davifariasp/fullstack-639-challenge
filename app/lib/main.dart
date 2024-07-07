import 'package:app/app.dart';
import 'package:app/app_module.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_modular/flutter_modular.dart';

//configurando para notificacoes em segundo plano
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  debugPrint("Handling a background message: $message");
}

void main() async{
  //necessario por conta do assincronismo
  WidgetsFlutterBinding.ensureInitialized();

  //config do firebase
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //configurando firebase
  await Firebase.initializeApp();

  return runApp(ModularApp(module: AppModule(), child: const MyApp()));
}
