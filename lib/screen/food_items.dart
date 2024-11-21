import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food_model.dart';
import 'package:flutter_application_1/repository/food_list_service.dart';

class FoodList extends StatefulWidget {
  final String name;
  const FoodList({super.key, required this.name});

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  final FoodService foodService = FoodService();

  void _incrementQuantity(FoodItem item) {
    setState(() {
      item.quantity++;
    });
  }

  void _decrementQuantity(FoodItem item) {
    setState(() {
      if (item.quantity > 0) {
        item.quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency : true,
        title: const Text('Food List'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart_rounded))
        ],
      ),
      body: FutureBuilder<List<FoodCategory>>(
        future: foodService.fetchFoodCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            final foodCategories = snapshot.data!;
            return ListView.builder(
              itemCount: foodCategories.length,
              itemBuilder: (context, categoryIndex) {
                final category = foodCategories[categoryIndex];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          category.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: category.items.length,
                      itemBuilder: (context, itemIndex) {
                        final item = category.items[itemIndex];
                        return ListTile(
                          title: Text(item.name),
                          subtitle: Text('₹${item.price.toStringAsFixed(2)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => _decrementQuantity(item),
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => _incrementQuantity(item),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
