import 'package:app/View/Screens/Home/home_page.dart';
import 'package:app/View/Screens/Login/login_page.dart';
import 'package:app/View/Screens/Register/register_page.dart';
import 'package:app/View/Widgets/auth_check.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/',
        child: (context) => const AuthCheck(),
        transition: TransitionType.fadeIn);
    r.child('/login',
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
