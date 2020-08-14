import 'package:flutter/material.dart';
import './modals/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(
        primarySwatch : Colors.orange,
        accentColor: Colors.redAccent,
        fontFamily: 'Quicksand',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    
  ];

  bool _showSwitch = false;

  List<Transaction> get _recentTransaction{
      return _userTransaction.where((tx){
        return tx.date.isAfter(
          DateTime.now().subtract(Duration(days: 7),),
        );
      }).toList();
    }

  void addNewTransaction(String title, double amount, DateTime chosenDate) {
    final _newTran = Transaction(
        title: title,
        amount: amount,
        date: chosenDate,
        id: DateTime.now().toString()
    );
    setState(() {
      _userTransaction.add(_newTran);
    });     
  }

  void deleteTransaction(String id){
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  void startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return NewTransaction(addNewTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
        title: Text("Personal Expenses", style: TextStyle(fontFamily: 'OpenSans'),),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), 
          onPressed: () => startAddNewTransaction(context),
          )
        ],
      );

    final txList = Container(
             height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
             child: TransactionList(_userTransaction,deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if(isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Show Chart :"),
                Switch(value: _showSwitch, onChanged: (val){
                  setState(() {
                    _showSwitch = val;
                  });
                }),
              ],
            ),

          if(!isLandscape) Container(
             height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.3,
             child: Chart(_recentTransaction)),
          if(!isLandscape) txList,


          if(isLandscape) _showSwitch ? Container(
             height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.8,
             child: Chart(_recentTransaction)) : txList,
                     
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => startAddNewTransaction(context),
          child: Icon(Icons.add), 
        ),
    );
  }
}
