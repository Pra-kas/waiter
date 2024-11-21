class FoodItem {
  final String name;
  final double price;
  int quantity;

  FoodItem({
    required this.name,
    required this.price,
    this.quantity = 0,
  });

  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      name: map['name'],
      price: map['price'].toDouble(),
      quantity: map['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}

class FoodCategory {
  final String name;
  final List<FoodItem> items;

  FoodCategory({
    required this.name,
    required this.items,
  });

  factory FoodCategory.fromMap(Map<String, dynamic> map, String name) {
    var items = (map['items'] as List).map((item) => FoodItem.fromMap(item)).toList();
    return FoodCategory(
      name: name,
      items: items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }
}
