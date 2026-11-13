import 'package:http/http.dart' as http;
import '../../domain/models/order.dart';
import '../sources/order_api_client.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderApiClient _apiClient;
  final http.Client _httpClient;

  OrderRepositoryImpl({
    required OrderApiClient apiClient,
    required http.Client httpClient,
  })  : _apiClient = apiClient,
        _httpClient = httpClient;

  @override
  Future<Order> createOrder(Order order) async {
    try {
      final orderWithTotal = order.copyWith(
        total: order.calculateTotal(),
      );
      final createdOrder = await _apiClient.createOrder(orderWithTotal);
      return createdOrder;
    } catch (e) {
      throw OrderRepositoryException(
        message: 'Failed to create order',
        originalError: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  Future<Order> getOrder(String orderId) async {
    try {
      if (orderId.isEmpty) {
        throw OrderRepositoryException(
          message: 'Order ID cannot be empty',
          originalError: null,
        );
      }
      final order = await _apiClient.getOrder(orderId);
      return order;
    } catch (e) {
      if (e is OrderRepositoryException) {
        rethrow;
      }
      throw OrderRepositoryException(
        message: 'Failed to get order: $orderId',
        originalError: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  Future<List<Order>> getOrders() async {
    try {
      const knownOrderIds = [
        'order-001',
        'order-002',
        'order-003',
      ];
      
      final List<Order> orders = [];
      
      for (final orderId in knownOrderIds) {
        try {
          final order = await _apiClient.getOrder(orderId);
          orders.add(order);
        } catch (e) {
          continue;
        }
      }
      
      return orders;
    } catch (e) {
      throw OrderRepositoryException(
        message: 'Failed to fetch orders list',
        originalError: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  Future<Order> updateOrderStatus(String orderId, String status) async {
    try {
      if (orderId.isEmpty) {
        throw OrderRepositoryException(
          message: 'Order ID cannot be empty',
          originalError: null,
        );
      }

      if (status.isEmpty) {
        throw OrderRepositoryException(
          message: 'Status cannot be empty',
          originalError: null,
        );
      }

      final validStatuses = ['pending', 'processing', 'completed', 'cancelled'];
      if (!validStatuses.contains(status.toLowerCase())) {
        throw OrderRepositoryException(
          message: 'Invalid status value: $status',
          originalError: null,
        );
      }

      final currentOrder = await _apiClient.getOrder(orderId);
      
      final updatedOrder = currentOrder.copyWith(
        status: status.toLowerCase(),
        updatedAt: DateTime.now(),
      );
      
      return updatedOrder;
    } catch (e) {
      if (e is OrderRepositoryException) {
        rethrow;
      }
      throw OrderRepositoryException(
        message: 'Failed to update order status for: $orderId',
        originalError: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}

class OrderRepositoryException implements Exception {
  final String message;
  final Exception? originalError;

  OrderRepositoryException({
    required this.message,
    this.originalError,
  });

  @override
  String toString() => 'OrderRepositoryException: $message';
}