import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  final String baseUrl;

  ApiHelper({required this.baseUrl});

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      return response;
    } catch (error) {
      throw Exception('API 요청 실패: $error');
    }
  }
}
