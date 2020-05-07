import 'package:flutter/material.dart';
import '../widges/category_items.dart';
import 'package:meals/models/category.dart';
import '../widges/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Category> dummyData = Dummy_Categories;
    return GridView.builder(
        padding: const EdgeInsets.all(25),
        itemBuilder: (ctx, index) {
          return CategoryItems(dummyData[index].title, dummyData[index].color, dummyData[index].id);
        },
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
        ),
        itemCount: dummyData.length,
    );
  }
}
