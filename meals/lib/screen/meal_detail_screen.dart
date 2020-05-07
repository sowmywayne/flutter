import 'package:flutter/material.dart';
import '../widges/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static String routeName = '/detail-meal';

  Widget _buildSelectionTitle(BuildContext ctx, String title){
    return Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              title, 
              style: Theme.of(ctx).textTheme.title,
            ),
          );
  }


  Widget _buildContainer(Widget child){
    return  Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            height: 150.0,
            width: 300.0,
            child: child
    );   
  }

  @override
  Widget build(BuildContext context) {
    final mealName = ModalRoute.of(context).settings.arguments as String;

    final mealDetail = DUMMY_MEALS.firstWhere((meal) {
      return meal.title == mealName;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          mealName,
          overflow: TextOverflow.fade,
           
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
          children: <Widget>[
            Container(
              height: 300.0,
              width: double.infinity,
              child: Image.network(
                mealDetail.imageUrl,
                fit: BoxFit.cover,
                ),
            ),
            _buildSelectionTitle(context, 'Ingredients'),

            _buildContainer(ListView.builder(
                itemBuilder: (ctx, index){
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 4.0,
                      ),
                      child: Text(mealDetail.ingredients[index])
                      ),
                  );
                },
                itemCount: mealDetail.ingredients.length,
              ),
            ),
            _buildSelectionTitle(context, 'Steps'),
            _buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index){
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text('# ${(index + 1)}'),
                          ),
                          title: Text(mealDetail.steps[index]),
                      ),
                      Divider(
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                  );
                },
                itemCount: mealDetail.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed:() {
          Navigator.of(context).pop(mealDetail.id);   
        } ,
      ),
    );
  }
} 