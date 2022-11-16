import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';

int id = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotification =
    new FlutterLocalNotificationsPlugin();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

String? selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  print(
      'notification${notificationResponse.id} action tapped: ${notificationResponse.actionId} with payload ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    print('notification action taped with input ${notificationResponse.input}');
  }
}

class MainPageControl extends GetxController {
  // Rx<Widget> currentPage = CurrentToDoPage().obs;
  Rx<int> currentPageIndex = 0.obs;

  changePage(int page) {
    switch (page) {
      case 0:
        currentPageIndex.value = 0;
        // currentPage.value = CurrentToDoPage();
        break;
      case 1:
        currentPageIndex.value = 1;
        // currentPage.value = AllToDoPage();
        break;
      case 2:
        currentPageIndex.value = 2;
        // currentPage.value = MinePage();
        break;
      default:
        currentPageIndex.value = 0;
        // currentPage.value = CurrentToDoPage();
        break;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await _configureLocalTimeZone();

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        !kIsWeb && Platform.isLinux
            ? null
            : await flutterLocalNotification.getNotificationAppLaunchDetails();
    String initialRoute = '/home';
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload =
          notificationAppLaunchDetails!.notificationResponse?.payload;
      print('------selectedNotificationPayload=$selectedNotificationPayload');
      initialRoute = '/newToDo';
      // Get.toNamed("/newToDo");
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotification.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == navigationActionId) {
            selectNotificationStream.add(notificationResponse.payload);
          }
          break;
      }
    }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
  }

  Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotification.show(
        id++, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }

  Future<void> showNotificationWithActions() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channelId', 'channelName',
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            actions: <AndroidNotificationAction>[
          AndroidNotificationAction(
            urlLaunchActionId,
            'action 1',
            icon: DrawableResourceAndroidBitmap('ic_launcher'),
            contextual: true,
          ),
          AndroidNotificationAction(
            navigationActionId,
            'action 2',
            titleColor: Colors.red,
            icon: DrawableResourceAndroidBitmap('ic_launcher'),
          )
        ]);
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotification
        .show(id++, 'title', 'body', notificationDetails, payload: 'item z');
  }

  Future<void> scheduleDailyTenAMNotification() async {
    await flutterLocalNotification.zonedSchedule(
        0,
        'daily ten notification title',
        'daily ten notification body',
        _nextInstanceOfTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'daily channelId', 'daily channelName',
              channelDescription: 'daily desc'),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 10,);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  @override
  void onClose() {
    selectNotificationStream.close();
    super.onClose();
  }
}
