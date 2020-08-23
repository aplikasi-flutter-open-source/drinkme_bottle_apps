import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final NotificationHelper _singleton = NotificationHelper._internal();

  factory NotificationHelper() => _singleton;

  NotificationHelper._internal() {
    if (Platform.isIOS) {
      _requestIOSPermission();
    }
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingIOs = IOSInitializationSettings();
    var initSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingIOs);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: (String payload) {
      print('payload $payload');
      return;
    });
  }

  _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void showNotification() async {
    var android = AndroidNotificationDetails('id', 'channel', 'description',
        priority: Priority.High, importance: Importance.High);
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Coba Notification', 'Demo Notification Deskripsi', platform,
        payload: 'Welcome to the Local Notification demo ');
  }

  Future<void> scheduleAlarm(int idNotif, DateTime dateTime) async {
    var time = Time(dateTime.hour, 01, 00);
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;
    var androidPlatformChannelSpesifics = AndroidNotificationDetails(
        'Water Drink Reminder ID',
        'Water Drink Reminder',
        'Notification for reminder you to drink',
        icon: 'app_icon',
        sound: RawResourceAndroidNotificationSound('sound_reminder'),
        largeIcon: DrawableResourceAndroidBitmap('right_notif'),
        vibrationPattern: vibrationPattern,
        priority: Priority.High,
        importance: Importance.High,
        enableVibration: true,
        enableLights: true,
        color: Colors.lightBlue,
        ledColor: Colors.lightBlue,
        styleInformation: MediaStyleInformation(),
        ledOnMs: 1000,
        ledOffMs: 500);
    var iOSPlatformChannelSpesifics =
        IOSNotificationDetails(sound: 'sound_reminder');
    var platformChannelSpesifics = NotificationDetails(
        androidPlatformChannelSpesifics, iOSPlatformChannelSpesifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        idNotif,
        'Hai... Waktunya Minum',
        'Jam Menunjukkan pukul ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute-1)}:${_toTwoDigitString(time.second)}',
        time,
        platformChannelSpesifics);
  }

  void notificationOurNeedNoSchedule() async {
    var vibrationPattern = Int64List(5);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;
    var androidPlatformChannelSpesifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime channel description',
        icon: 'app_icon',
        sound: RawResourceAndroidNotificationSound('sound_reminder'),
        largeIcon: DrawableResourceAndroidBitmap('right_notif'),
        vibrationPattern: vibrationPattern,
        priority: Priority.High,
        importance: Importance.High,
        enableVibration: true,
        enableLights: true,
        color: Colors.lightBlue,
        ledColor: Colors.lightBlue,
        ledOnMs: 1000,
        ledOffMs: 500);
    var iOSPlatformChannelSpesifics =
        IOSNotificationDetails(sound: 'sound_reminder');
    var platformChannelSpesifics = NotificationDetails(
        androidPlatformChannelSpesifics, iOSPlatformChannelSpesifics);
    await flutterLocalNotificationsPlugin.show(0, 'Hai... Waktunya Minum',
        'Jam Menunjukkan pukul ', platformChannelSpesifics);
  }

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }
}
