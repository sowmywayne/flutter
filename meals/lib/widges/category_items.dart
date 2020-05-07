import 'package:flutter/material.dart';
import '../screen/category_meals_screen.dart';


class CategoryItems extends StatelessWidget {
  final String title;
  final Color color;
  final String id;

  CategoryItems(this.title, this.color, this.id);

  void _selectCategory(BuildContext ctx, String id) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName, 
      arguments: {
        'title': title, 
        'id': id
      });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCategory(context, id),
      splashColor:  Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
