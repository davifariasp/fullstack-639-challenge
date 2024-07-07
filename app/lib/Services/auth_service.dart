import 'package:app/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      return {'message': 'Erro ao logar'};
    }
  }

  Future<Map<String, dynamic>> register(
      String name, String email, String password, String tokenDevice) async {

    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'name': name,
          'email': email,
          'password': password,
          'tokenDevice': tokenDevice
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data;
    } else {
      return {'message': 'Erro ao registrar'};
    }
  }
}
