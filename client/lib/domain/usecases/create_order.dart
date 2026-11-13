import 'package:reto/domain/models/order.dart';
import 'package:reto/domain/repositories/order_repository.dart';

class CreateOrder {
  final OrderRepository repository;

  CreateOrder({required this.repository});

  Future<Order> call(Order order) async {
    try {
      if (order.items.isEmpty) {
        throw Exception('Order must have at least one item');
      }

      final createdOrder = await repository.createOrder(order);
      return createdOrder;
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }
}