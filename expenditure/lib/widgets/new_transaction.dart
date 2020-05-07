import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void _submitData() {
    final enterTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);
     

    if(enterTitle.isEmpty || enterAmount <= 0 || selectedDate == null) {
      return;
    }

     widget.addNewTransaction(enterTitle, enterAmount, selectedDate);
     Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2019), 
      lastDate: DateTime.now(), 
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          selectedDate = pickedDate;
        });
          
        
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10.0,
            ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Platform.isIOS ? CupertinoTextField(
                placeholder: 'title',
                controller: titleController,
                ) :
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('No Date Chosen'),
                  
                  Platform.isIOS ? CupertinoButton(
                    child: Text('Choose Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                    onPressed: _presentDatePicker,
                  ): FlatButton(
                    child: Text('Choose Date'),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatePicker,
                    ),
                ],
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
