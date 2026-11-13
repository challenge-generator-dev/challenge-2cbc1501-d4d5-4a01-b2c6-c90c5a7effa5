import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  const Order._();

  const factory Order({
    required String id,
    required String userId,
    required List<OrderItem> items,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0.0) double total,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  double calculateTotal() {
    return items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }
}

@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    required String productId,
    required String name,
    required double price,
    required int quantity,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
}