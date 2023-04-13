import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/features/home/models/product_model.dart';

import '../../cart/cart_bloc.dart';
import '../../cart/cart_event.dart';
import '../../cart/cart_state.dart';

class ProductTileWidget extends StatelessWidget {
  final Product cartProducts;
  const ProductTileWidget({super.key, required this.cartProducts});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  cartProducts.imageUrl,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartProducts.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      cartProducts.description,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\$${cartProducts.price}"),
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            int itemCount = state.cartItems[cartProducts] ?? 0;
                            return (itemCount == 0)
                                ? Container(
                                    padding: EdgeInsets.all(10),
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.lightGreen)),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: (() {
                                          context.read<CartBloc>().add(
                                              CartAddToCartEvent(
                                                  cartItem: cartProducts));
                                        }),
                                        child: const Text(
                                          'ADD',
                                          style: TextStyle(
                                              color: Colors.lightGreen,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  )
                                : Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                              CartRemoveFromCartEvent(
                                                  cartItem: cartProducts));
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                      Text(itemCount.toString()),
                                      IconButton(
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                              CartAddToCartEvent(
                                                  cartItem: cartProducts));
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
