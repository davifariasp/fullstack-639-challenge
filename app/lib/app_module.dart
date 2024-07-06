import 'package:app/View/Screens/Home/home.dart';
import 'package:app/View/Screens/Login/login.dart';
import 'package:app/View/Screens/Register/register.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/',
        child: (context) => const LoginPage(),
        transition: TransitionType.fadeIn);
    r.child('/register',
        child: (context) => const RegisterPage(),
        transition: TransitionType.fadeIn);
    r.child('/home',
        child: (context) => const HomePage(),
        transition: TransitionType.fadeIn);
  }
}
