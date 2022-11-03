package com.realmeparts;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.database.ContentObserver;
import android.os.Handler;
import android.os.IBinder;
import android.os.UserHandle;
import android.provider.Settings.Secure;
import android.util.Log;

public class DT2WService extends Service {

    private static final boolean DEBUG = false;
    private static final String TAG = "DT2WService-X3";

    private static final String DT2W_NODE = "/proc/touchpanel/double_tap_enable";

    private CustomSettingsObserver mCustomSettingsObserver;

    @Override
    public void onCreate() {
        super.onCreate();
        if (DEBUG) Log.i(TAG, "onCreate");
        mCustomSettingsObserver = new CustomSettingsObserver(Utils.getUiThreadHandler(), this);
        getContentResolver().registerContentObserver(Secure.getUriFor(Secure.DOUBLE_TAP_TO_WAKE),
                    false, mCustomSettingsObserver, UserHandle.USER_CURRENT);
        mCustomSettingsObserver.update();
    }

    @Override
    public void onDestroy() {
        getContentResolver().unregisterContentObserver(mCustomSettingsObserver);
        super.onDestroy();
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    private class CustomSettingsObserver extends ContentObserver {
        private Context mContext;

        CustomSettingsObserver(Handler handler, Context context) {
            super(handler);
            mContext = context;
        }

        void update() {
            boolean enabled = Secure.getIntForUser(mContext.getContentResolver(),
                    Secure.DOUBLE_TAP_TO_WAKE, 0, UserHandle.USER_CURRENT) == 1;
            if (DEBUG) Log.i(TAG, "SettingsObserver update: enabled=" + enabled);
            Utils.setValue(DT2W_NODE, enabled);
        }

        @Override
        public void onChange(boolean selfChange) {
            update();
        }
    }
}
