import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food_model.dart';
import 'package:flutter_application_1/repository/food_list_service.dart';
import 'package:flutter_application_1/screen/food_items.dart';

class MenuSections extends StatelessWidget {
  MenuSections({super.key});

  @override
  Widget build(BuildContext context) {
    final FoodService foodService = FoodService();
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Center(child: Text('The BrewBerryCafe Menu')),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: EdgeInsets.all(width / 20),
        child: FutureBuilder<List<FoodCategory>>(
          future: foodService.fetchFoodCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available'));
            }

            final menuSections = snapshot.data!;

            return ListView.builder(
              itemCount: menuSections.length,
              itemBuilder: (context, index) {
                final category = menuSections[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(top: width / 10)),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: width / 10),
                        child: SizedBox(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                category.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodList(name: category.name),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      backgroundColor: Colors.brown.shade50,
    );
  }
}
