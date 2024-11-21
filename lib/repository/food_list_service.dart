import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/models/food_model.dart';

class FoodService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref().child('menu');

  Future<List<FoodCategory>> fetchFoodCategories() async {
    DataSnapshot snapshot = await _db.get();
    Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value as Map);

    List<FoodCategory> categories = [];
    data.forEach((key, value) {
      categories.add(FoodCategory.fromMap(Map<String, dynamic>.from(value), key));
    });

    return categories;
  }
}
