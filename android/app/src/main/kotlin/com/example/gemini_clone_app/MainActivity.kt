package com.example.gemini_clone_app

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import com.example.gemini_clone_app.Notifications

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Notifications.createNotificationChannels(this)
    }
}
