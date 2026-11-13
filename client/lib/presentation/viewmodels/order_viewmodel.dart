import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/order.dart';
import '../../domain/usecases/create_order.dart';
import '../../domain/usecases/get_order.dart';

class OrderViewModel extends StateNotifier<AsyncValue<Order?>> {
  final CreateOrder createOrder;
  final GetOrder getOrder;

  OrderViewModel({
    required this.createOrder,
    required this.getOrder,
  }) : super(const AsyncValue.data(null));

  Future<void> submitOrder(Order order) async {
    state = const AsyncValue.loading();
    try {
      final createdOrder = await createOrder(order);
      state = AsyncValue.data(createdOrder);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> fetchOrder(String orderId) async {
    state = const AsyncValue.loading();
    try {
      final order = await getOrder(orderId);
      state = AsyncValue.data(order);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}