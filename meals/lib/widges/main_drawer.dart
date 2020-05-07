import 'package:flutter/material.dart';
import '../screen/filter_screen.dart';

class MainDrawer extends StatelessWidget {

  Widget _buildListTile(String title, IconData icon, Function tapHandler ){
    return ListTile(
            leading: Icon(
              icon,
              size: 26.0,
              textDirection: TextDirection.ltr,
            ),
            title: Text(
              title,
              style: TextStyle(
                fontFamily: 'RobotoCondened',
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: tapHandler,
          );
  }

  // void _pageChanger(){

  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: Key('heloo'),
      child: Column(
        children: <Widget>[
          Container(
            height: 120.0,
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Cooking',
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          _buildListTile(
            'Meal', 
            Icons.restaurant,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            }
            ),
          _buildListTile(
            'Filters', 
            Icons.filter,
            () {
              Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
            }
            ),
        ],
      ),
    );
  }
}
