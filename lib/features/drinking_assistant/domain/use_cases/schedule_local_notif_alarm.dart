import 'package:drinking_assistant/core/utils/notification_helper.dart';

class ScheduleAlarm {
  final NotificationHelper notificationHelper;

  ScheduleAlarm(this.notificationHelper);

  call(int idNotif, DateTime dateTime) {
    notificationHelper.scheduleAlarm(idNotif, dateTime);
  }
}
