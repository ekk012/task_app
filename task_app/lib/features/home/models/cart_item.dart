import 'package:task_app/features/home/models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem(this.product, {this.quantity = 1});
}
