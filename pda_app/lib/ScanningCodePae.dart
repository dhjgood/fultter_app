import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(ScanningCodePage());

class ScanningCodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<ScanningCodePage> {
  static const platformChannel =
  const MethodChannel('com.example.platform_channel/text');
  String textContent = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    platformChannel.setMethodCallHandler((methodCall) async {
      switch (methodCall.method) {
        case 'showText':
          String content = await methodCall.arguments['content'];
          if (content != null && content.isNotEmpty) {
            setState(() {
              textContent = content;
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
      title: "Flutter Demo",
      home: Scaffold(
        appBar: AppBar(
          title: Text('接收扫码信息'),
        ),
        body: Padding(
          padding: EdgeInsets.all(40.0),
          child: Text(textContent),
        ),
      ),
    );
  }
}
