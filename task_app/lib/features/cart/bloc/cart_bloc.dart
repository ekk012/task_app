import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:task_app/data/cart_items.dart';
import 'package:task_app/features/cart/bloc/cart_event.dart';
import 'package:task_app/features/cart/bloc/cart_state.dart';





import '../../home/models/product_model.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial(cartItems: {})) {
    on<CartAddToCartEvent>(_onAddToCartEvent);
    on<CartRemoveFromCartEvent>(_onRemoveFromCartEvent);
  }

  void _onAddToCartEvent(CartAddToCartEvent event, Emitter<CartState> emit) {
    final Map<Product, int> updatedCartItems = Map.from(state.cartItems);
    if (updatedCartItems.containsKey(event.cartItem)) {
      updatedCartItems[event.cartItem] = updatedCartItems[event.cartItem]! + 1;
    } else {
      updatedCartItems[event.cartItem] = 1;
    }
    emit(CartSuccessState(updatedCartItems));
  }

  void _onRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    final Map<Product, int> updatedCartItems = Map.from(state.cartItems);
    if (updatedCartItems.containsKey(event.cartItem)) {
      if (updatedCartItems[event.cartItem] == 1) {
        updatedCartItems.remove(event.cartItem);
      } else {
        updatedCartItems[event.cartItem] =
            updatedCartItems[event.cartItem]! - 1;
      }
    }
    emit(CartSuccessState(updatedCartItems));
  }
}
