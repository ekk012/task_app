import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart/bloc/cart_bloc.dart';
import '../../cart/bloc/cart_event.dart';
import '../../cart/bloc/cart_state.dart';
import '../../home/models/cart_item.dart';
import '../../home/models/product_model.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Summary'),
        backgroundColor: Colors.green,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartInitial) {
            return const Center(
              child: Text('No items in cart'),
            );
          } else {
            final cartItems = state.cartItems.entries.toList();
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final entry = cartItems[index];
                      final item = CartItem(entry.key, quantity: entry.value);
                      return ListTile(
                        title: Text(item.product.name),
                        subtitle: Text('\$${item.product.price}'),
                        trailing: SizedBox(
                          width: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  context.read<CartBloc>().add(
                                        CartRemoveFromCartEvent(
                                            cartItem: item.product),
                                      );
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              Text(item.quantity.toString()),
                              IconButton(
                                onPressed: () {
                                  context.read<CartBloc>().add(
                                        CartAddToCartEvent(
                                            cartItem: item.product),
                                      );
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:'),
                      Text(
                        '\$${_calculateTotalPrice(cartItems)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  String _calculateTotalPrice(List<MapEntry<Product, int>> cartItems) {
    double totalPrice = 0;
    for (final entry in cartItems) {
      final item = CartItem(entry.key, quantity: entry.value);
      totalPrice += item.quantity * double.parse(item.product.price);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
