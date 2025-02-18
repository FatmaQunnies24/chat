import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_messenger_app/data/models/user_model.dart';
import 'package:youtube_messenger_app/data/services/base_repository.dart';

class AuthRepository extends BaseRepository {
  final String baseUrl = 'http://localhost:8080/api/auth';

  Future<UserModel> signIn({required String email, required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['accessToken'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);
        return UserModel.fromJson(data);
      } else {
        throw Exception('Failed to sign in');
      }
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<UserModel> signUp({
    required String fullName,
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': fullName,
          'username': username,
          'email': email,
          'phoneNumber': phoneNumber,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['accessToken'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);
        return UserModel.fromJson(data);
      } else {
        throw Exception('Failed to sign up');
      }
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }
}