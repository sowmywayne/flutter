import 'package:flutter/material.dart';
import 'package:meals/widges/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availabMeals;

  CategoryMealsScreen(this.availabMeals);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeal;
  var _loadedInitData = false;
  @override
  void initState() {
    super.initState();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeal.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  void didChangeDependencies() {
    if (_loadedInitData == false) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryID = routeArgs['id'];

      displayedMeal = widget.availabMeals.where((meal) {
        return meal.categories.contains(categoryID);
      }).toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              title: displayedMeal[index].title,
              imageUrl: displayedMeal[index].imageUrl,
              affordability: displayedMeal[index].affordability,
              duration: displayedMeal[index].duration,
              complexity: displayedMeal[index].complexity,
              removeItem: _removeMeal,
            );
          },
          itemCount: displayedMeal.length,
        ),
      ),
    );
  }
}
