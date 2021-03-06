import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screen/meal_detail_screen.dart';


class MealItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function removeItem;

  MealItem({
    @required this.title,
    @required this.duration,
    @required this.imageUrl,
    @required this.affordability,
    @required this.complexity,
    @required this.removeItem
  });

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple: return 'Simple';
      case Complexity.Hard: return 'Hard';
      case Complexity.Challenging: return 'Challenging';  
      default: return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable: return 'Affordable';
      case Affordability.Luxurious: return 'Luxurious';
      case Affordability.Pricey: return 'Pricey';  
      default: return 'Unknown';
    }
  }

  void _selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealDetailScreen.routeName,
      arguments: title
    ).then((result){
      if(result != Null){
        removeItem(result);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15), 
                    topRight: Radius.circular(15),
                    ),
                  child: Image.network(
                    imageUrl, 
                    height: 250, 
                    width: double.infinity, 
                    fit: BoxFit.cover
                    ),  
                ),
                Positioned(
                  bottom: 20.0,
                  right: 10.0,
                  child: Container(
                    width: 300.0,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 30,
                      ),
                    child: Text(
                      title, 
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      ),
                  ),
                ),
              ],
            ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.schedule),
                    SizedBox(width: 6,),
                    Text('$duration min'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.work),
                    SizedBox(width: 6,),
                  Text(complexityText),
                  ],
                ), 
                Row(
                  children: <Widget>[
                    Icon(Icons.attach_money),
                    SizedBox(width: 6,),
                  Text(affordabilityText),
                  ],
                ), 
              ],
            ),
          )  
          ],
        ),
      ),
    );

  }
}