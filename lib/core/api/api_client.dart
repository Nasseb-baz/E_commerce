import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_constants.dart';

class ApiClient {
  Future<Map<String, dynamic>> post(
    String endpoint, {
    required Map<String, dynamic> body,
    String? token,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');

    print('================ API REQUEST ================');
    print('POST URL: $url');
    print('BODY: $body');
    print('TOKEN: $token');

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    print('================ API RESPONSE ================');
    print('STATUS CODE: ${response.statusCode}');
    print('BODY: ${response.body}');

    final data = response.body.isNotEmpty
        ? jsonDecode(response.body)
        : <String, dynamic>{};

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    }

    throw Exception(
      data['message'] ?? data['error'] ?? 'Request failed',
    );
  }
}