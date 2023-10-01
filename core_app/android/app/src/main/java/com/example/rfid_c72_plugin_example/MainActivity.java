package com.example.rfid_c72_plugin_example;

import android.os.Bundle;
import android.view.KeyEvent;
import android.widget.TextView;

import java.util.Collections;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL_NAME = "rfid";

    TextView number;
    int count;
    String data = "Hello from native Android!";


    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        // Register the method channel with the Flutter engine
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL_NAME)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("dispatchKeyEvent")) {
                                // Retrieve the data sent from the Flutter side
                                // Construct the data to be sent

// Invoke the method channel and pass the data
                                new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL_NAME)
                                        .invokeMethod("methodName", Collections.singletonMap("key", data));

                                // Process the data as needed
                                System.out.println("Received data: " + data);
                            }
                        }
                );
    }



    @Override
    public boolean dispatchKeyEvent(KeyEvent event) {
        int action, keycode;
        action=event.getAction();
        keycode=event.getKeyCode();

        System.out.println("the action is : "+action);
        System.out.println("the keycode is : "+keycode);


        switch (action){
            case 0:
            {

                if(KeyEvent.KEYCODE_VIDEO_APP_5==keycode){
                    System.out.println("out act"+KeyEvent.KEYCODE_VIDEO_APP_5);
                    System.out.println("the event is : "+event);


                    count++;
                    String num=String.valueOf(count);
//                    number.setText(num);

                }
                break;
            }
            case 1:

                if(KeyEvent.KEYCODE_VOLUME_DOWN==keycode){
                    count--;
                    String num=String.valueOf(count);
//                    number.setText(num);
                    System.out.println("the event issssssssssss : "+event);

                }
                break;


        }
        return super.dispatchKeyEvent(event);
    }
}