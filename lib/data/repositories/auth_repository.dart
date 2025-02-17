import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtube_messenger_app/data/models/user_model.dart';

class AuthRepository {
  final String baseUrl = "http://localhost:8080/api/auth";

  Future<UserModel> signIn({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String accessToken = data['accessToken'];
      final String userId = data['id'];
      final String email = data['email'];
      final String role = data['role'][0];

      // Save the token locally (e.g., using shared_preferences)
      // await saveToken(accessToken);

      return UserModel(
        uid: userId,
        username: username,
        fullName: username, // You can adjust this based on your backend response
        email: email,
        phoneNumber: '', // Adjust based on your backend response
        role: role,
      );
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<void> signOut() async {
    // Clear the token from local storage
    // await clearToken();
  }

// Add methods to save and clear the token using shared_preferences or any other local storage
}