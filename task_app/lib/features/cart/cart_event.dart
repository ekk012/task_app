
import 'package:equatable/equatable.dart';

import '../home/models/product_model.dart';


abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartInitialEvent extends CartEvent {}

class CartAddToCartEvent extends CartEvent {
  final Product cartItem;

  const CartAddToCartEvent({required this.cartItem});

  @override
  List<Object?> get props => [cartItem];
}

class CartRemoveFromCartEvent extends CartEvent {
  final Product cartItem;

  const CartRemoveFromCartEvent({required this.cartItem});

  @override
  List<Object?> get props => [cartItem];
}

