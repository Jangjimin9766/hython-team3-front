import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static const String baseUrl = 'http://13.124.207.140:8080'; // 고정 URL

  // POST 요청
  Future<http.Response> post(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final requestHeaders = {
      'Content-Type': 'application/json',
      ...?headers,
    };

    print("=== [POST 요청 정보] ===");
    print("Request URL: $url");
    print("Request Headers: $requestHeaders");
    print("Request Body: ${json.encode(body)}");

    try {
      final response = await http.post(
        url,
        headers: requestHeaders,
        body: json.encode(body),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      return response; // 그대로 http.Response 반환
    } catch (error) {
      print("POST 요청 실패: $error");
      throw Exception('POST 요청 실패: $error');
    }
  }
}
