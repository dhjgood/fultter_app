import 'package:flutter/material.dart';

void main()=>runApp(DeliverGoods());

class DeliverGoods extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StatefulWidgetApp();
  }
}

class StatefulWidgetApp extends State<DeliverGoods>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(title: Text("发货")),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child:Stack(
            children: <Widget>[
              Positioned()
            ],
          ),
        ),
      ),

    );
  }
}