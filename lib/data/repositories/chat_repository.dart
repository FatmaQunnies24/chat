import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatRepository {
  final String baseUrl = "http://localhost:8080/api/chat";
  final String? token;

  ChatRepository({this.token});

  Future<void> sendMessage({
    required String chatRoomId,
    required String senderId,
    required String receiverId,
    required String content,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'chatRoomId': chatRoomId,
        'senderId': senderId,
        'receiverId': receiverId,
        'content': content,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }
  }

// Add other methods to interact with the backend
}