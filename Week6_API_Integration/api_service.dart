import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart'; // Adjust import if you renamed the file

class ApiService {
  static const String _url = 'https://dummyjson.com/users';

  Future<List<CompanyUser>> fetchCompanyUsers() async {
    try {
      final response = await http.get(Uri.parse(_url)).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = jsonDecode(response.body) as Map<String, dynamic>;
        final List<dynamic> userList = decodedJson['users'] as List<dynamic>;

        return userList.map((jsonItem) => CompanyUser.fromJson(jsonItem as Map<String, dynamic>)).toList();
      } else {
        throw Exception("Server responded with code: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Network error: Please verify your internet connection.");
    }
  }
}