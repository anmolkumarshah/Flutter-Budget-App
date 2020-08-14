import 'package:expense_App/modals/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransaction;
  final Function deleteTx;

  TransactionList(this._userTransaction, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 570,
      child: _userTransaction.isEmpty
          ? LayoutBuilder(builder: (ctx, constrains) {
              return Column(
                children: <Widget>[
                  Text('No Transaction Added Yet!!'),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: constrains.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: FittedBox(
                              child: Text(
                            '₹ ${_userTransaction[index].amount}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                    ),
                    title: Text(_userTransaction[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Text(DateFormat.yMMMEd()
                        .format(_userTransaction[index].date)),
                    trailing: MediaQuery.of(context).size.width > 460 ? 
                      FlatButton.icon(
                       onPressed: () => deleteTx(_userTransaction[index].id),
                       icon: Icon(Icons.delete, color: Colors.red,),
                       label: Text("Delete"),
                      ) : IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => deleteTx(_userTransaction[index].id)
                    ),
                  ),
                );
              },
              itemCount: _userTransaction.length,
            ),
    );
  }
}
