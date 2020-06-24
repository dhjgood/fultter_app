import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';


void main() => runApp(DeliverGoods());

class DeliverGoods extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StatefulWidgetApp();
  }
}

class StatefulWidgetApp extends State<DeliverGoods> {
  String titleName = "发货";
  String resName   = "列表~";
  String getmode   = "请选择扫码方式";
  // item列表参数
  double FontSize = 25;
  double Cheight  = 60;

  //获取扫码信息配置
  static const platformChannel = const MethodChannel('com.pad.getcode/text');
  String code = "";
  //获取扫码信息方法
  void initState() {
    // TODO: implement initState
    super.initState();
    platformChannel.setMethodCallHandler((methodCall) async {
      switch (methodCall.method) {
        case 'showText':
          String content = await methodCall.arguments['content'];
          if (content != null && content.isNotEmpty) {
            setState(() {
              this.code = content;
              print("接收信息："+content);
            });
            return 'success';
          } else {
            throw PlatformException(
              code: 'error', message: '解码信息接收失败',);
          }
          break;
        default:
          throw MissingPluginException();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(245, 245, 245, 1),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text(this.titleName),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      ListTile(title: Text(this.titleName + this.resName,style: TextStyle(
                        fontSize: 20
                      ),)),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.black12,
                                width: 0.5
                            ),
                            top: BorderSide(
                                color: Colors.black12,
                                width: 0.5
                            ),
                          )
                        ),
                        width: double.infinity,
                        height: 180,
                        padding: EdgeInsets.fromLTRB(0, 0, 5,0),
//                        color:  Color.fromRGBO(241, 243, 245, 1),
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int i) {
                            return Container(
                                color: Colors.white,
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                padding: EdgeInsets.fromLTRB(25, 20, 0,0),
                                width: double.infinity,
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:double.infinity ,
                                    height: this.Cheight,
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black12,
                                              width: 1
                                          ),
                                        )
                                    ),
                                    child: Text(
                                      "产品名称："+this.code,
                                      softWrap: false,
                                      textAlign: TextAlign.left,
                                      overflow:TextOverflow.ellipsis ,
                                      maxLines: 1,
                                      style: TextStyle(fontSize: this.FontSize),
                                    ),
                                  ), Container(
                                    width:double.infinity ,
                                    height: this.Cheight,
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black12,
                                              width: 1
                                          ),
                                        )
                                    ),
                                    child: Text(
                                      "已扫数量：10",
                                      softWrap: false,
                                      textAlign: TextAlign.left,
                                      overflow:TextOverflow.ellipsis ,
                                      maxLines: 1,
                                      style: TextStyle(fontSize: this.FontSize),
                                    ),
                                  ),
                                ],
                              )
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 70,
                  color: Colors.red,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
//                          decoration: BoxDecoration(
//                            border: Border(
//                              right: BorderSide(
//                                color: Colors.black54,
//                                width: 0.5
//                              )
//                            )
//                          ),
                          height: 70,
                          color: Colors.white,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20,0, 0, 0),
                            alignment: Alignment(-1,0),
                            height: 70,
                            color: Colors.white,
                            child: Text("扫码方式："+this.getmode,
                              style: TextStyle(
                                  fontSize: 20
                              ),),
                          ),
                        ),
                        onTap:(){
                            print("2112");
                            showDialog<Widget>(
                              context: context,
                              builder: (BuildContext context) {
                                return  SimpleDialog(
//                                  title:  Text('选择扫码方式',style:  TextStyle(fontSize: 20),),
                                  children: <Widget>[
                                     SimpleDialogOption(
                                      child:  Text('箱码',style: TextStyle(fontSize: 18),textAlign: TextAlign.center,),
                                      onPressed: () {
                                        setState(() {
                                          this.getmode = "箱码";
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                     Divider(),
                                    SimpleDialogOption(
                                      child:  Text('跺码',style:  TextStyle(fontSize: 18),textAlign: TextAlign.center,),
                                      onPressed: () {
                                        setState(() {
                                          this.getmode = "跺码";
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                        }
                        )
                      ],
                    )
                ),
                Container(
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 70,
                              color: Colors.cyan,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 70,
                              color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 70,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}


