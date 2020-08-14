import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData(){
    final enteredText = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if(enteredText.isEmpty || enteredAmount <= 0 || selectedDate == null){
      return;
    }

    widget.addTransaction(
      enteredText,
      enteredAmount,
      selectedDate,
    );
    Navigator.of(context).pop();
  }

  void presentDateSelector(){
    showDatePicker(context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2019),
    lastDate: DateTime.now()
    ).then((pickedDate){
      if(pickedDate == null){
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
          child: Container(
        padding: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Card(
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,  
                onSubmitted: (_) => submitData(),            
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Text(selectedDate == null ? "No Date Chosen!" : 'Choosen Date : ${DateFormat.yMEd().format(selectedDate)}'),
                    FlatButton(onPressed: presentDateSelector, child: Text("Choose Date", style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),),)
                  ],
                ),
              ),
              RaisedButton(
                onPressed: submitData,
                child: Text('Add Transaction',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),),
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
