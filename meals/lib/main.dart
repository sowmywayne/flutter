import 'package:flutter/material.dart';

import './widges/dummy_data.dart';
import 'package:meals/screen/filter_screen.dart';
import './screen/meal_detail_screen.dart';
import './screen/tab_screen.dart';
import './screen/category_meals_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;


  void _setFilter(Map<String, bool> filterData){
    setState(() {
      _filters = filterData; 
      _availableMeals = DUMMY_MEALS.where((meal) {
        if(_filters['gluten'] && !meal.isGlutenFree){
          return false;
        }
        if(_filters['lactose'] && !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegetarian'] && !meal.isVegetarian){
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan){
          return false;
        }
      }).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: TabScreen(),
      title: 'DeliMeals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink, 
        accentColor: Colors.amber,
        fontFamily: 'Raleway',
        canvasColor: Color.fromRGBO(255, 254, 229, 1.0),
        textTheme: TextTheme(
          body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1.0),

          ),
          body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1.0),
          ),
          title: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold
            ),
        ),  
      ),
      initialRoute: '/',
    routes: {
      '/': (ctx) => TabScreen(),
      CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
      MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
      FilterScreen.routeName: (ctx) => FilterScreen(_setFilter),

    },  
    );
  }
}

