import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VTime {
  static String now() {
    return DateTime.now().toString().split('.')[0];
  }

  static String nowFormatted() {
    return DateFormat('dd/MM/yy kk:mm').format(DateTime.now());
  }

  static String nowTimeStamp() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static String defaultFormat(String date, {String from = 'yyyy-MM-ddTHH:mm:ss.mmm', String to = 'dd/MM/yyyy'}) {
    try {
      DateFormat dateFormatFrom = DateFormat(from);
      DateTime dateTime = dateFormatFrom.parse(date);
      return DateFormat(to).format(dateTime);
    } catch (e) {
      return '';
    }
  }

  static Timestamp? dateTimeStringToTimestamp(String dateTimeString) {
    DateTime? dateTime = DateTime.tryParse(dateTimeString);
    if (dateTime != null) return Timestamp.fromDate(dateTime);
    return null;
  }

  static String fromTimeStampToView(Timestamp? timestamp) {
    if (timestamp == null) return '';
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    String dateString = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    return convertToView(dateString);
  }

  static String fromTimeStampToDefaultFormat(Timestamp? timestamp, {String format = 'dd MMMM yyyy'}) {
    if (timestamp == null) return '';
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    return DateFormat(format).format(date);
  }

  static int yearDurationFromTimeStamp(Timestamp? timestamp) {
    if (timestamp == null) return 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    int dateMilliSecond = dateTime.millisecondsSinceEpoch;
    int nowMilliSecond = DateTime.now().millisecondsSinceEpoch;
    int diff = nowMilliSecond - dateMilliSecond;
    return (diff / 31557600000).ceil();
  }

  static String convertToView(String date, {String from = 'yyyy-MM-dd HH:mm:ss', String to = 'dd/MM/yy kk:mm'}) {
    DateFormat dateFormatFrom = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime dateTime = dateFormatFrom.parse(date);

    int dateMilliSecond = dateTime.millisecondsSinceEpoch;
    int nowMilliSecond = DateTime.now().millisecondsSinceEpoch;
    int diff = nowMilliSecond - dateMilliSecond;
    if (diff < 0) {
      return DateFormat(to).format(dateTime);
    }
    if (diff < 60000) {
      //Kurang dari 1 jam
      for (int i = 1; i < 60; i++) {
        if (i < i * 60000) {
          return '$i detik yang lalu';
        }
      }
    } else if (diff < 3600000) {
      //Kurang dari 1 jam
      for (int i = 1; i < 60; i++) {
        if (i < i * 60000) {
          return '$i menit yang lalu';
        }
      }
    } else if (diff < 86400000) {
      // Kurang dari 1 hari
      for (int i = 1; i < 24; i++) {
        if (i < i * 3600000) {
          return '$i jam yang lalu';
        }
      }
    } else if (diff < 604800000) {
      // Kurang dari 1 minggu
      for (int i = 1; i < 7; i++) {
        if (i < i * 86400000) {
          return '$i hari yang lalu';
        }
      }
    } else if (diff < 2629800000) {
      // Kurang dari 1 bulan
      for (int i = 1; i < 4; i++) {
        if (i < i * 604800000) {
          return '$i minggu yang lalu';
        }
      }
    } else if (diff < 31556926000) {
      // Kurang dari 1 tahun
      for (int i = 1; i < 12; i++) {
        if (i < i * 2629800000) {
          return '$i bulan yang lalu';
        }
      }
    } else if (diff < 31556926000 * 10) {
      // Kurang dari 1 tahun
      for (int i = 1; i < 12; i++) {
        if (i < i * 31556926000) {
          return '$i tahun yang lalu';
        }
      }
    } else {
      return '>10 tahun yang lalu';
    }
    return DateFormat(to).format(dateTime);
  }

  static String addZero(int value) {
    if (value == null) return '';
    if (value < 10) {
      return '0${value.toString()}';
    }
    return value.toString();
  }

  static String timeOfDayToString(TimeOfDay timeOfDay) {
    return '${addZero(timeOfDay.hour)}:${addZero(timeOfDay.minute)}:00';
  }

  static int selisihTahun(String dateA, {String? dateB}) {
    DateFormat dateFormatFrom = DateFormat('yyyy-MM-dd');
    DateTime dateTimeA = dateFormatFrom.parse(dateA);
    DateTime dateTimeB = DateTime.now();

    if (dateB != null) {
      dateTimeB = dateFormatFrom.parse(dateB);
    }

    int dateTimeAMs = dateTimeA.millisecondsSinceEpoch;
    int dateTimeBMs = dateTimeB.millisecondsSinceEpoch;
    int diffMs = dateTimeBMs - dateTimeAMs;
    int diffYear = (diffMs / 31556952000).ceil();

    return diffYear;
  }
}
