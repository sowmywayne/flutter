import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.amberAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontWeight: FontWeight.bold, 
            fontFamily: 'OpenSans', 
            fontSize: 18
            ),
          button: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),  
            ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(title: TextStyle(fontFamily: 'OpenSans', fontSize: 20, fontWeight: FontWeight.bold)),
        )
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((ele) {
      return ele.date.isAfter(DateTime.now().subtract(Duration(days: 7),));
    }).toList();
  }



  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle, 
      amount: txAmount, 
      id: DateTime.now().toString(), 
      date: chosenDate,
      );

      setState(() {
        _userTransactions.add(newTx);
      });
  }



  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(
        onTap: () {},
        child: NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      );
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx){
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscap = MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS ? CupertinoNavigationBar(
      middle: Text('Expenditure'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          )
        ],
      ),
    ) : AppBar(
        title: Text('Expenditure'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add,), onPressed:() => _startAddNewTransaction(context),)
        ],
      );

      final txList =  Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
              child: TransactionList(_userTransactions, _deleteTransaction),
              ); 

    final pageBody = SafeArea (
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscap) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Text('show chart'),
              Switch.adaptive( value: _showChart, onChanged: (val) {
                  setState(() {
                    _showChart = val;
                  });
              } ,)
            ],
            ),
            if(!isLandscap) Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.3,
              child: Chart(_recentTransactions),
              ),
              if(!isLandscap) txList,
              if(isLandscap) _showChart ?  Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.65,
              child: Chart(_recentTransactions),
              ): txList
           
          ],
        ),  
      ),
    );

     
    return Platform.isIOS ? CupertinoPageScaffold(
      navigationBar: appBar,
       child: pageBody,
       
    ) : Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation:  FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
