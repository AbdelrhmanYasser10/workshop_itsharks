import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:smart_notification_manager/core/enums/notification_type.dart';
import 'package:smart_notification_manager/core/models/config/local_notifier_config.dart';
import 'package:smart_notification_manager/core/models/notifier_models/local_notifier_model.dart';
import 'package:smart_notification_manager/core/services/notifier_sender/local_notifier_sender.dart';
import 'package:smart_notification_manager/core/services/notifier_setup/local_notifier_setup.dart';

abstract class NotificationConfig {
  static Future<void> config() async {
    final notificationPermission =
        await FirebaseMessaging.instance.requestPermission();
    if (notificationPermission.authorizationStatus ==
        AuthorizationStatus.authorized) {
      if (Platform.isIOS) {
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken != null) {
          print(FirebaseMessaging.instance.getToken());
        }
      } else {
        print("FCM TOKEN :--->");
        print(await FirebaseMessaging.instance.getToken());
      }

      final fcmToken = await FirebaseMessaging.instance.getToken();
      await LocalNotifierSetup().initialize(
        config: LocalNotificationConfig(
          isWorkInBackground: true, // Enables background notifications.
          onBgNotifResponse:
              (details) {}, // Handle background notification response.
          onNotifResponse:
              (details) {}, // Handle notification response when tapped.
          onError: () {}, // Handle initialization errors.
          onSucess: () {}, // Handle successful initialization.
        ),
      );
      FirebaseMessaging.onMessage.listen((event) {
        print("Notification");
        print(event.notification!.title);
        print(event.notification!.body);
        LocalNotificationSender().sendNotification(
          LocalNotificationModel(
            isWorkInBackground: true,
            notificationType: NotificationType.basic,
            title: event.notification!.title!,
            body: event.notification!.body!,
          ),
        );
      });

      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        LocalNotificationSender().sendNotification(
          LocalNotificationModel(
            isWorkInBackground: true,
            notificationType: NotificationType.basic,
            title: event.notification!.title!,
            body: event.notification!.body!,
          ),
        );
      });
    }
  }

  // firebase dashboard
  static Future<String> getAccessToken() async {
    final jsonString = await rootBundle.loadString(
      'assets/keys/gemini-app-70313-ea645477a0ae.json',
    );
    final accountCredentials = auth.ServiceAccountCredentials.fromJson(
      jsonString,
    );
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
    final client = await auth.clientViaServiceAccount(
      accountCredentials,
      scopes,
    );
    return client.credentials.accessToken.data;
  }

  static Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
    required Map<String, String> data,
  }) async {
    final String accessToken = await getAccessToken();
    final String fcmUrl =
        'https://fcm.googleapis.com/v1/projects/gemini-app-70313/messages:send';
    final response = await http.post(
      Uri.parse(fcmUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(<String, dynamic>{
        'message': {
          'token': token,
          'notification': {'title': title, 'body': body},
          'data': data, // Add custom data here
          'android': {
            'notification': {
              "sound": "custom_sound",
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              // Required for tapping to trigger response
              'channel_id': 'high_importance_channel',
            },
          },
          'apns': {
            'payload': {
              'aps': {"sound": "custom_sound.caf", 'content-available': 1},
            },
          },
        },
      }),
    );
    if (response.statusCode == 200) {
      print('Notification sent successfully');
      print("Herrrrrrrrrreeeeeeeeeeeeeee");
      print("Herrrrrrrrrreeeeeeeeeeeeeee");
      print("Herrrrrrrrrreeeeeeeeeeeeeee");
      print("Herrrrrrrrrreeeeeeeeeeeeeee");
      print("Herrrrrrrrrreeeeeeeeeeeeeee");
      print("Herrrrrrrrrreeeeeeeeeeeeeee");
      print("Herrrrrrrrrreeeeeeeeeeeeeee");
      print("Herrrrrrrrrreeeeeeeeeeeeeee");
    } else {
      print('Failed to send notification: ${response.body}');
      print('Failed to send notification: ${response.body}');
      print('Failed to send notification: ${response.body}');
      print('Failed to send notification: ${response.body}');
      print('Failed to send notification: ${response.body}');
      print('Failed to send notification: ${response.body}');
      print('Failed to send notification: ${response.body}');
      print('Failed to send notification: ${response.body}');
      print('Failed to send notification: ${response.body}');
      print('Failed to send notification: ${response.body}');
      print('Failed to send notification: ${response.body}');
      print('Failed to send notification: ${response.body}');
      print('Failed to send notification: ${response.body}');
      print('Failed to send notification: ${response.body}');
      print('Failed to send notification: ${response.body}');
      print('Failed to send notification: ${response.body}');
      print('Failed to send notification: ${response.body}');
    }
  }
}
