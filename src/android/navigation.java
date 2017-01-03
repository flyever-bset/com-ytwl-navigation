package com.ytwl.navigation;

import java.net.URISyntaxException;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import android.app.Activity;
import android.content.Intent;
import android.view.View;
import android.util.Log;
import android.net.Uri;

/**
 * This class echoes a string called from JavaScript.
 */
public class navigation extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("open")) {
            String message = args.getString(0);
            this.open(message, callbackContext);
            return true;
        }
        return false;
    }

    private void open(String message, CallbackContext callbackContext) {
        if(message != null && message.length()>0){
            Activity activity =this.cordova.getActivity();
            Uri mapUri = Uri.parse(message);
            Intent intent = new Intent(Intent.ACTION_VIEW, mapUri);
            activity.startActivity(intent); //启动调用
        }
    }
}
