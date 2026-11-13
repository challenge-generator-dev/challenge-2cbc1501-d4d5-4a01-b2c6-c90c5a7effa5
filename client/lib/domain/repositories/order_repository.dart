import '../models/order.dart';

abstract class OrderRepository {
  Future<Order> createOrder(Order order);
  Future<Order> getOrder(String orderId);
  Future<List<Order>> getOrders();
  Future<Order> updateOrderStatus(String orderId, String status);
}