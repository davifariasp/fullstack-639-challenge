import 'package:app/app.dart';
import 'package:app/app_module.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'firebase_options.dart';

void main() async {

  //necessario por conta do assincronismo
  WidgetsFlutterBinding.ensureInitialized();

  //config do firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  return runApp(ModularApp(module: AppModule(), child: const MyApp()));
}
