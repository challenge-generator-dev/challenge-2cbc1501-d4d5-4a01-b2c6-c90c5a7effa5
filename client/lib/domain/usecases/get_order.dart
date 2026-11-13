import 'package:reto/domain/models/order.dart';
import 'package:reto/domain/repositories/order_repository.dart';

class GetOrder {
  final OrderRepository repository;

  GetOrder({required this.repository});

  Future<Order> call(String orderId) async {
    try {
      if (orderId.isEmpty) {
        throw Exception('Order ID cannot be empty');
      }

      final order = await repository.getOrder(orderId);
      return order;
    } catch (e) {
      throw Exception('Failed to get order: $e');
    }
  }
}