//  Copyright (c) 2016, 2017, 2018,
//  Poplar Hill Informatics and the American College of Radiology
//  All rights reserved.
//  Use of this source code is governed by the open source license
//  that can be found in the odw/LICENSE file.
//  Primary Author: Jim Philbin <jfphilbin@gmail.edu>
//  See the AUTHORS file for other contributors.
//
import 'package:constants/src/epoch.dart';

//import 'package:core/src/global.dart';
//import 'package:core/src/utils/string.dart';
// import 'package:core/src/error/date_time_errors.dart';

// ignore_for_file: public_member_api_docs

class EpochDate {
  final int year;
  final int month;
  final int day;

  /// Constructor
  const EpochDate(this.year, this.month, this.day);

  /// Returns a [String] corresponding to _this_. If [asDicom] is _true_
  /// the format is 'yyyymmdd'; otherwise the format is 'yyyy-mm-dd'.
  String asString({bool asDicom = true}) {
    final yy = _digits4(year);
    final mm = _digits2(month);
    final dd = _digits2(day);
    return asDicom ? '$yy$mm$dd' : '$yy-$mm-$dd';
  }

  /// Returns a 4 digit [String], left padded with '0' if necessary.
  String _digits4(int n) {
    if (n > 9999) return null;
    if (n >= 1000) return '$n';
    if (n >= 100) return '0$n';
    if (n >= 10) return '00$n';
    return '000$n';
  }

  /// Returns a 2 digit [String], left padded with '0' if necessary.
  String _digits2(int n) {
    if (n > 99) return null;
    if (n >= 10) return '$n';
    return '0$n';
  }

  @override
  String toString() => asString(asDicom: false);

  /// Returns
  /// [Gregorian Calendar](https://en.wikipedia.org/wiki/Gregorian_calendar)
  /// year/month/day as a [list<int>] of length 3.
  ///
  /// Preconditions:
  ///     [day] is number of days since 1970-01-01 and is in the range:
  ///         [epochFromDays(Int64.min), epochFromDays(Int64.max - 719468)]
  static EpochDate fromDay(int day) => Epoch.dayToDate(day);

  static const EpochDate kZero = EpochDate(1970, 1, 1);
}
