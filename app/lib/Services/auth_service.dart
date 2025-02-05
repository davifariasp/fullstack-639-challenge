import 'package:app/Services/http_use.dart';
import 'package:app/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final HttpUse httpUse = HttpUse();

  Future<Map<String, dynamic>> login(String email, String password, double lat, double lon, String tokenDevice) async {
    final response = await httpUse.post(
      url: '$baseUrl/users/login',
      headers: {'Content-Type': 'application/json'},
      body: {'email': email, 'password': password, 'lat': lat, 'lon': lon, 'tokenDevice': tokenDevice},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      return {'message': 'Erro ao logar'};
    }
  }

  Future<Map<String, dynamic>>  logout(String tokenDevice) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/logout'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {'tokenDevice': tokenDevice},
      ),
    );

    if (response.statusCode == 200) {
      return {'message': 'Deslogado com sucesso'};
    } else {
      return {'message': 'Erro ao registrar'};
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
