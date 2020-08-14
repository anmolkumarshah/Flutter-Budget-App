import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints){
        return Column(
        children: <Widget>[
          Container(height: constraints.maxHeight * 0.15,
          child: FittedBox(child: Text('₹${spendingAmount.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.bold),))),
          SizedBox(height: constraints.maxHeight * 0.05,),
          Container(child: Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius:BorderRadius.circular(10),
                  color:Colors.grey,
                ),
              ),
              FractionallySizedBox(heightFactor: spendingPctOfTotal,child: Container(
                decoration: BoxDecoration(color:Colors.blue,borderRadius: BorderRadius.circular(10)),
                
              ),)
            ],),
          ),),
          SizedBox(height: constraints.maxHeight * 0.05,),
          Container(
            height: constraints.maxHeight * 0.15,
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: FittedBox(child: Text(label, style: TextStyle(fontWeight: FontWeight.bold),))),
        ],
      );
    }); 
  }
}