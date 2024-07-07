import 'package:app/Interfaces/i_http_use.dart';
import 'package:http/http.dart';
import 'dart:convert';

class HttpUse extends IHttpUse {
  final client = Client();

  @override
  Future<Response> delete(
      {required String url, required Map<String, String>? headers}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Response> get(
      {required String url, Map<String, String>? headers}) async {
    // TODO: implement get
    return await client.get(Uri.parse(url), headers: headers);
  }

  @override
  Future<Response> post(
      {required String url,
      required Map<String, String>? headers,
      required Map<String, dynamic>? body}) async {

    return await client.post(Uri.parse(url),
        body: json.encode(body), headers: headers);
  }

  @override
  Future<Response> put(
      {required String url,
      required Map<String, dynamic>? headers,
      required Map<String, dynamic>? body}) async {
    // TODO: implement put
    throw UnimplementedError();
  }
}
