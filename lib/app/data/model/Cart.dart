class Cart {
  final String cart_id;
  final String product_id;
  final String? user_id;
  final String size;
  final String color;
  int qty;
  bool accept;
  Cart(this.cart_id, this.product_id, this.user_id, this.size, this.color,
      this.qty, this.accept);
}
