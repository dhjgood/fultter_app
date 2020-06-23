import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ScanningCodePae.dart';
import './page/DeliverGoods.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: "PDA扫码系统",
      theme: ThemeData(
//        fontFamily: "Cairo",
        scaffoldBackgroundColor:Colors.white,
//        textTheme:Theme.of(context).textTheme.apply(displayColor: Colors.black )
      ),
      home: HomeContext(),
      routes:{
        '/scode':(context)=>ScanningCodePage(),
        '/dgoods':(context)=>DeliverGoods(),
      } ,
    );
  }
}

//HomeContextHomeContextreturnScaffold(
//appBar: AppBar(title: Text("PDA扫码系统"),),
//body: ,
//),
class HomeContext extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDA扫码系统")),
        body: GridView.count(
           crossAxisCount: 3,
           crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            childAspectRatio: 0.9,
            padding: EdgeInsets.all(20),
            children: <Widget>[
              MyItem("发货",Icons.airport_shuttle,"/dgoods"),
            ],
          ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
//              accountName: Text("admin"),
              accountEmail: Text("管理员"),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundImage: new ExactAssetImage("img/admin.png"),
                ),
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new ExactAssetImage("img/bg.png"),),),
            ),
            new Divider(),
            new  ListTile(
              trailing: new Icon(Icons.redo),
              title: new Text("退出登录"),
              onTap: () {
                Navigator.of(context).pop();
//                Navigator.push(
//                    context,
//                    new MaterialPageRoute(
////                        builder: (BuildContext context) => new AboutPage()));
              },

            ),
          ],
        ),
      ),
      );
  }
}


class MyItem extends StatelessWidget{
  String   name;
  IconData icon;
  String   path;

  MyItem(this.name,this.icon,this.path){

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child:     Container(
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius:BorderRadius.circular(13),
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: 100,
              height: 80,
//            color: Colors.cyanAccent,
              child: Center(
                child: Icon(this.icon,size: 50,color: Colors.white,),
              ),
            ),
            Text(
                this.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0,color: Colors.white)
            )
          ],
        ),


      ),
      onTap: (){
         Navigator.pushNamed(context, this.path);
      },
    );

  }
}

