package pda.app;

import android.content.BroadcastReceiver;
import android.content.IntentFilter;
import io.flutter.app.FlutterActivity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import java.util.HashMap;
import java.util.Map;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    private static final String TAG = "打印信息--->";
    private static final String RES_ACTION = "android.intent.action.SCANRESULT";  //PDA 广播标识
    String  STR = "";  //初始化
    MethodChannel methodChannel;
    IntentFilter intentFilter;
    BroadcastReceiver scanReceiver;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        initScanner(); //调用
//        GeneratedPluginRegistrant.registerWith(this);
        methodChannel = new MethodChannel(getFlutterView(),"com.example.platform_channel/text");//1
    }

    @Override
    protected void onResume() {
        super.onResume();
        Map map = new HashMap();
        map.put("content",STR);
        methodChannel.invokeMethod("showText", map, new MethodChannel.Result() {//2
            @Override
            public void success(Object o) {
                Log.d(TAG,"解码信息发送成功！");
            }
            @Override
            public void error(String errorCode, String errorMsg, Object errorDetail) {
//                Log.d(TAG,"errorCode:"+errorCode+" errorMsg:"+errorMsg+" errorDetail:"+(String)errorDetail);
                Log.d(TAG,"解码信息发送失败！");
            }
            @Override
            public void notImplemented() {
                Log.d(TAG,"发送解码异常");
            }
        });
    }

    //设置频道监听变化
    private void initScanner(){
        //扫描结果的意图过滤器action一定要使用"android.intent.action.SCANRESULT"
        intentFilter = new IntentFilter();
        intentFilter.addAction(RES_ACTION);
        //**********重要
        //注册广播接受者
        scanReceiver = new ScannerResultReceiver();
        registerReceiver(scanReceiver, intentFilter);
    }

    //获取扫码后的值
    private class ScannerResultReceiver extends BroadcastReceiver{
        public void onReceive(Context context, Intent intent) {
            final String scanResult = intent.getStringExtra("value");
//            Log.d(TAG,"接收到结果："+scanResult);
            STR = scanResult;
            onResume();
        }
    }

}