import 'package:flutter/material.dart';

import '../../home/models/product_model.dart';

@immutable
class CartState {
  final Map<Product, int> cartItems;
  const CartState({required this.cartItems});

  int get totalItems => cartItems.values.fold(0, (acc, val) => acc + val);
}

abstract class CartActionState extends CartState {
  const CartActionState({required Map<Product, int> cartItems})
      : super(cartItems: cartItems);
}

class CartInitial extends CartState {
  CartInitial({required Map cartItems}) : super(cartItems: {});
}

class CartSuccessState extends CartState {
  const CartSuccessState(Map<Product, int> cartItems)
      : super(cartItems: cartItems);
}

class AddToCartActionState extends CartActionState {
  final Product cartItem;

  const AddToCartActionState(
      {required Map<Product, int> cartItems, required this.cartItem})
      : super(cartItems: cartItems);
}

class RemoveFromCartActionState extends CartActionState {
  final Product cartItem;

  const RemoveFromCartActionState(
      {required Map<Product, int> cartItems, required this.cartItem})
      : super(cartItems: cartItems);
}
