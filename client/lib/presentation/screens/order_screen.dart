import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/order.dart';
import '../viewmodels/order_viewmodel.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _orderIdController = TextEditingController();
  final List<OrderItem> _currentItems = [];
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  void dispose() {
    _orderIdController.dispose();
    _productNameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _addItem() {
    if (_productNameController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty) {
      final price = double.tryParse(_priceController.text) ?? 0.0;
      final quantity = int.tryParse(_quantityController.text) ?? 1;

      setState(() {
        _currentItems.add(OrderItem(
          productId: 'prod_${DateTime.now().millisecondsSinceEpoch}',
          name: _productNameController.text,
          price: price,
          quantity: quantity,
        ));
      });

      _productNameController.clear();
      _priceController.clear();
      _quantityController.clear();
    }
  }

  void _removeItem(int index) {
    setState(() {
      _currentItems.removeAt(index);
    });
  }

  Future<void> _submitOrder() async {
    if (_currentItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agrega al menos un producto al pedido')),
      );
      return;
    }

    final order = Order(
      id: 'order_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'user_123',
      items: _currentItems,
      status: 'pending',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await ref.read(orderViewModelProvider.notifier).submitOrder(order);
  }

  Future<void> _fetchOrder() async {
    final orderId = _orderIdController.text.trim();
    if (orderId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa un ID de pedido')),
      );
      return;
    }

    await ref.read(orderViewModelProvider.notifier).fetchOrder(orderId);
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderViewModelProvider);

    ref.listen<OrderViewModelState>(orderViewModelProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${next.error}'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (next.order != null && previous?.order == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pedido procesado exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Pedidos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle('Crear Nuevo Pedido'),
              const SizedBox(height: 16),
              _buildProductInputFields(),
              const SizedBox(height: 16),
              _buildItemsList(),
              const SizedBox(height: 16),
              _buildSubmitButton(orderState),
              const Divider(height: 32),
              _buildSectionTitle('Consultar Pedido'),
              const SizedBox(height: 16),
              _buildOrderSearchField(orderState),
              const SizedBox(height: 16),
              _buildOrderDetails(orderState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildProductInputFields() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _productNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre del producto',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Precio',
                      border: OutlineInputBorder(),
                      prefixText: '\$ ',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Cantidad',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
              label: const Text('Agregar Producto'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsList() {
    if (_currentItems.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No hay productos en el pedido',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _currentItems.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final item = _currentItems[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('Cantidad: ${item.quantity}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeItem(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubmitButton(OrderViewModelState state) {
    final isLoading = state.isLoading;

    return ElevatedButton(
      onPressed: isLoading ? null : _submitOrder,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text(
              'Confirmar Pedido',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
    );
  }

  Widget _buildOrderSearchField(OrderViewModelState state) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _orderIdController,
            decoration: const InputDecoration(
              labelText: 'ID del pedido',
              border: OutlineInputBorder(),
              hintText: 'Ingresa el ID del pedido',
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: state.isLoading ? null : _fetchOrder,
          child: state.isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Buscar'),
        ),
      ],
    );
  }

  Widget _buildOrderDetails(OrderViewModelState state) {
    if (state.order == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No hay información del pedido',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    final order = state.order!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('ID', order.id),
            _buildDetailRow('Usuario', order.userId),
            _buildDetailRow('Estado', order.status),
            _buildDetailRow(
              'Fecha de creación',
              _formatDate(order.createdAt),
            ),
            _buildDetailRow(
              'Última actualización',
              _formatDate(order.updatedAt),
            ),
            const Divider(),
            const Text(
              'Productos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...order.items.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${item.name} x${item.quantity}'),
                      Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                    ],
                  ),
                )),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '\$${order.calculateTotal().toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}