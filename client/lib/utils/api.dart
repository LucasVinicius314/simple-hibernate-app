import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static final client = http.Client();

  static const _apiProtocol = String.fromEnvironment(
    'API_PROTOCOL',
    defaultValue: 'http',
  );

  static const _apiAuthority = String.fromEnvironment(
    'API_AUTHORITY',
    defaultValue: 'localhost',
  );

  static const _path = '/api/';

  static Uri _getUri({
    required String uri,
    required Map<String, dynamic> queryParameters,
  }) {
    const uriFunction = _apiProtocol == 'https' ? Uri.https : Uri.http;

    return uriFunction(_apiAuthority, '$_path$uri', queryParameters);
  }

  static Future<dynamic> get({
    required String path,
    required Map<String, dynamic> queryParameters,
  }) async {
    final res = await client.get(
      _getUri(
        uri: path,
        queryParameters: queryParameters,
      ),
    );

    return jsonDecode(res.body);
  }

  static Future<dynamic> post({
    required String path,
    required Map<String, dynamic> queryParameters,
    required Map<String, dynamic> body,
  }) async {
    final res = await client.post(
      _getUri(
        uri: path,
        queryParameters: queryParameters,
      ),
      body: jsonEncode(body),
    );

    return jsonDecode(res.body);
  }

  static Future<dynamic> patch({
    required String path,
    required Map<String, dynamic> queryParameters,
    required Map<String, dynamic> body,
  }) async {
    final res = await client.patch(
      _getUri(
        uri: path,
        queryParameters: queryParameters,
      ),
      body: jsonEncode(body),
    );

    return jsonDecode(res.body);
  }

  static Future<dynamic> delete({
    required String path,
    required Map<String, dynamic> queryParameters,
    required Map<String, dynamic> body,
  }) async {
    final res = await client.patch(
      _getUri(
        uri: path,
        queryParameters: queryParameters,
      ),
      body: jsonEncode(body),
    );

    return jsonDecode(res.body);
  }
}
