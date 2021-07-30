import 'package:f_logs/f_logs.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  DateTimeUtils._();

  //DateTime Methods:-----------------------------------------------------------
  static int getCurrentTimeInMillis() {
    final now = DateTime.now();
    return now.millisecondsSinceEpoch;
  }

  static String getCurrentTimestamp(LogsConfig config) {
    final now = DateTime.now();
    return DateFormat(config.timestampFormat.toString()).format(now);
  }

  static String getTimeInMillis(LogsConfig config) {
    final now = DateTime.now();
    var fiftyDaysFromNow = now.add(Duration(days: -1));
    return DateFormat(config.timestampFormat.toString()).format(fiftyDaysFromNow);
  }

  static int? getStartAndEndTimestamps({required FilterType type}) {
    int? startTimeInMillis;

    //filter types
    const lastHour = "FilterType.LAST_HOUR";
    const twentyFourHour = "FilterType.LAST_24_HOURS";
    const today = "FilterType.TODAY";
    const week = "FilterType.WEEK";
    const all = "FilterType.ALL";

    //switch statement
    switch (type.toString()) {
      case lastHour:
        // data/time now
        var now = DateTime.now();
        // last hour
        var lh = now.subtract(Duration(hours: 1));
        debugPrint('${lh}');
        startTimeInMillis = lh.millisecondsSinceEpoch;
        break;
      case twentyFourHour:
        // data/time now
        var now = DateTime.now();
        // last twenty four hours from now
        var tfh = now.subtract(Duration(hours: 24));
        //debugPrint
        if (FLog.getDefaultConfigurations().isDevelopmentDebuggingEnabled) {
          debugPrint('${tfh}');
        }

        startTimeInMillis = tfh.millisecondsSinceEpoch;
        break;
      case today:
        // data/time now
        var now = DateTime.now();
        // midnight today
        var td = DateTime(now.year, now.month, now.day);
        //debugPrint
        if (FLog.getDefaultConfigurations().isDevelopmentDebuggingEnabled) {
          debugPrint('${td}');
        }

        startTimeInMillis = td.millisecondsSinceEpoch;
        break;
      case week:
        // data/time now
        var now = DateTime.now();
        // midnight today
        var td = DateTime(now.year, now.month, now.day);
        // last week from today
        var w = td.subtract(Duration(days: 7));
        //debugPrint
        if (FLog.getDefaultConfigurations().isDevelopmentDebuggingEnabled) {
          debugPrint('${w}');
        }

        startTimeInMillis = w.millisecondsSinceEpoch;
        break;
      case all:
        // all: i am going to set it to 2019, coz i wrote this library in 2019
        // no need to go all the way back to 1970
        var all = DateTime(2019, 1, 1);

        //debugPrint
        if (FLog.getDefaultConfigurations().isDevelopmentDebuggingEnabled) {
          debugPrint('${all}');
        }

        startTimeInMillis = all.millisecondsSinceEpoch;
        break;
    }

    return startTimeInMillis;
  }
}
