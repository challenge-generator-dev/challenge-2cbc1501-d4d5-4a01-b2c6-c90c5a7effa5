import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/models/order.dart';

class OrderApiClient {
  final http.Client _client;
  final String baseUrl;

  OrderApiClient({required this.baseUrl, http.Client? client})
      : _client = client ?? http.Client();

  Future<Order> createOrder(Order order) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/orders'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(order.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create order: ${response.statusCode}');
      }

      return Order.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  Future<Order> getOrder(String orderId) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/orders/$orderId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to get order: ${response.statusCode}');
      }

      return Order.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to get order: $e');
    }
  }
}