//  Copyright (c) 2016, 2017, 2018,
//  Poplar Hill Informatics and the American College of Radiology
//  All rights reserved.
//  Use of this source code is governed by the open source license
//  that can be found in the odw/LICENSE file.
//  Primary Author: Jim Philbin <jfphilbin@gmail.edu>
//  See the AUTHORS file for other contributors.
//
import 'package:base/base.dart';

// Urgent: convert this to use DataTime rather than EpochDate
// Urgent: move test code from core

/// A set of functions for handling dates in terms of
/// [Unix Epoch](https://en.wikipedia.org/wiki/Unix_time) days,
/// where day 0 of the Unix Epoch is 1970-01-01 (y=1970, m = 1, d = 1).
///
/// The algorithms for [dateToDay] and [dateToDay] come from
/// http://howardhinnant.github.io/date_algorithms.html

class Epoch {
  /// The first year of the epoch.
  final int minYear;

  /// The last year of the epoch.
  final int maxYear;

  /// The first year of the epoch in microseconds.
  final int kMinYearInMicroseconds;

  /// The last year of the epoch in microseconds.
  final int kMaxYearInMicroseconds;

  /// The minimum Unix Epoch day for this [Epoch].
  final int kMinDay;

  /// The maximum Unix Epoch day for this [Epoch].
  final int kMaxDay;

  /// Constructor
  Epoch(this.minYear, this.maxYear)
      : kMinDay = dateToDay(minYear, 1, 1),
        kMaxDay = dateToDay(maxYear, 12, 31),
        kMinYearInMicroseconds = dateToDay(minYear, 1, 1) * kMicrosecondsPerDay,
        kMaxYearInMicroseconds = dateToDay(maxYear, 1, 1) * kMicrosecondsPerDay;

  /// The minimum Unix Epoch day for this [Epoch].
  int get kMinMicrosecond => kMinDay * kMicrosecondsPerDay;

  /// The maximum Unix Epoch day for this [Epoch].
  int get kMaxMicrosecond => ((kMaxDay + 1) * kMicrosecondsPerDay) - 1;

  /// The total number of Epoch microseconds valid for this [Epoch].
  int get span => kMaxMicrosecond - kMinMicrosecond;

  /// Returns _true_ if [day] is a valid day in Epoch.
  bool isValidDay(int day) => day >= kMinDay && day <= kMaxDay;

  /// Returns _true_ if [us] is valid.
  bool isValidMicroseconds(int us) =>
      (us >= kMinMicrosecond) && (us <= kMaxMicrosecond);

  /// Returns _true_ if [us] is invalid.
  bool isNotValidMicroseconds(int us) => !isValidMicroseconds(us);

  /// Returns _true_ if [day] is invalid.
  bool isNotValidDay(int day) => !isValidDay(day);

  /// Returns a valid DateTime microsecond. if [us] is out of range it is
  /// clamped to the lower or upper bound for the Epoch.
  int toValidMicrosecond(int us) {
    if (us < kMinMicrosecond) return kMinMicrosecond;
    if (us > kMaxMicrosecond) return kMaxMicrosecond;
    return us;
  }

  /// Returns a valid DateTime microsecond. if [day] is out of range it is
  /// clamped to the lower or upper bound for the Epoch.
  int toValidDay(int day) {
    if (day < kMinDay) return kMinDay;
    if (day > kMaxDay) return kMaxDay;
    return day;
  }

  /// Returns _true_ if
  /// ```[year] >= global.minYear && [year] <= [global.maxYear]```.
  bool isValidYear(int year) => _inRange(year, minYear, maxYear);

  /// Returns _true_ if
  /// ```[us] >= kMinYearMicroseconds && [us] <= [kMaxYearMicroseconds]```.
  bool isValidYearInMicroseconds(int us) =>
      us >= kMinYearInMicroseconds && us <= kMaxYearInMicroseconds;

  /// If [us] [<] [kMinYearInMicroseconds] returns [kMinYearInMicroseconds].
  /// If [us] [>] [kMaxYearInMicroseconds] returns [kMaxYearInMicroseconds].
  /// Otherwise, returns [us].
  int toValidYearInMicroseconds(int us) => (us.isNegative)
      ? us % kMinYearInMicroseconds
      : us % kMaxYearInMicroseconds;

  /// Returns _true_ if [y], [m], and [d] correspond to a valid Gregorian date.
  bool isValidDate(int y, int m, int d) {
    if (!isValidYear(y) || !_isValidMonth(m)) return false;
    final lastDay =
        (m != 2) ? daysInCommonYearMonth[m] : (isLeapYear(y)) ? 29 : 28;
    return _inRange(d, 1, lastDay);
  }

  /// Returns _true_ if a valid date is not specified.
  bool isNotValidDate(int y, int m, int d) => !isValidDate(y, m, d);

  /// Returns a [DateTime] that corresponds to [us].
  DateTime microsecondToDate(int us) {
    if (isNotValidMicroseconds(us)) return null;
    final epochDay = us ~/ kMicrosecondsPerDay;
    return dayToDate(epochDay);
  }

  /// Returns a [String] representation of _this_.
  @override
  String toString() => '$runtimeType from year $minYear to year $maxYear';

  /// Returns the Epoch microsecond that corresponds to [y], [m], and [d].
  static int dateToMicroseconds(int y, int m, int d) =>
      dateToDay(y, m, d) * kMicrosecondsPerDay;

  /// Returns the EpochDay that corresponds to [day].
  /// The [DateTime] returned may not be valid for a particular [Epoch].
  static DateTime dayToDate(int day) {
    // if (day == 0) return EpochDate.kZero;
    final z = day + 719468;
    final era = ((z >= 0) ? z : z - 146096) ~/ 146097;
    final doe = z - (era * 146097);
    final yoe = _yearOfEra(doe);
    final nYear = yoe + (era * 400);
    final doy = doe - ((365 * yoe) + (yoe ~/ 4) - (yoe ~/ 100)); // [0, 365]
    final nm = ((5 * doy) + 2) ~/ 153; // [0, 11]
    final d = doy - (((153 * nm) + 2) ~/ 5) + 1; // [1, 31]
    final m = nm + ((nm < 10) ? 3 : -9); // [1, 12]
    final y = (m <= 2) ? nYear + 1 : nYear;
    return DateTime(y, m, d);
  }

  /// Returns the Unix Epoch day. Negative values indicate days prior to day 0.
  /// The day returned may not be valid for a particular [Epoch].
// Preconditions:
//     y-m-d represents a date in the (Gregorian) calendar
//     m is in [1, 12]
//     d is in [1, lastDayOfMonth(y, m)]
//     y is "approximately" in [min()/366, max()/366]
//     Exact range of validity is:
//         [epochFromDays(Int64.min), epochFromDays(Int64.max - 719468)]
//
// The following abbreviations are used in the following code:
//   - ny: normalized year to March 1
//   - era: a 400 year period
//   - yoe: year of ero
//   - doy: day of year
//   - doe: day of Epoch
//   - eDay: epoch day
//   - nm: normalized month number - March is 1
  static int dateToDay(int y, int m, int d) {
    const _zeroCEDay = -719468; // The zero day of the Christian Ero (CE).
    const _daysInEra = 146097; // The number of days in an Era.

    final ny = (m <= 2) ? y - 1 : y;
    final era = (ny >= 0 ? ny : ny - 399) ~/ 400;
    // [0, 399]
    final yoe = ny - (era * 400);
    // [0, 365]
    final doy = ((153 * (m + ((m > 2) ? -3 : 9))) + 2) ~/ 5 + (d - 1);
    // [0, 146096]
    final doe = (yoe * 365) + (yoe ~/ 4) - (yoe ~/ 100) + doy;
    return (era * _daysInEra) + doe + _zeroCEDay;
  }

  /// Returns the yearOfEra in number of days since Era Zero Day. The returned
  /// values is in the range: `0 <= yearOfEra <= 399`.
  static int _yearOfEra(int doe) =>
      ((doe - (doe ~/ 1460)) + (doe ~/ 36524) - (doe ~/ 146096)) ~/ 365;

  /// Returns _true_ if [y] is a leap year.
  ///
  /// Common years are computed as follows:
//. If (year is not divisible by 4) then (it is a common year)
//. else if (year is divisible by 100) then (it is a common year)
//. else if (year is not divisible by 400) then (it is a common year)
//. else (it is a leap year)
  static bool isLeapYear(int y) => y % 4 == 0 && (y % 100 != 0 || y % 400 == 0);

  /// Returns _true_ if [y] is a common year.
  static bool isCommonYear(int y) => !isLeapYear(y);

  /// Returns the [int] values of the last day in month [m] in year [y].
  static int lastDayOfMonth(int y, int m) =>
      (m != 2 || !isLeapYear(y)) ? daysInCommonYearMonth[m] : 29;

  /// Returns an [int] between 0 and 6, with 0 corresponding to Sunday.
  static int weekdayFromEpochDay(int z) =>
      (z >= -4) ? (z + 4).remainder(7) : (z + 5).remainder(7) + 6;

  /// Returns the number of days between weekday [x] and weekday [y].
  /// Both [x] and [y] must be integers in the range 0 - 6.
  static int weekdayDifference(int x, int y) {
    if (x < 0 || x > 6 && y < 0 || y > 6) throw Error();
    final n = (x >= y) ? x - y : (x + 7) - y;
    return n;
  }

  /// Returns the number of the  weekday _after_ [weekday].
  /// Note: Always returns a number between 0 and 6.
  int nextWeekday(int weekday) {
    if (weekday < 0 || weekday > 6) throw Error();
    return (weekday < 6) ? weekday + 1 : 0;
  }

  /// Returns the number of the weekday _before_ [weekday].
  /// Note: Always returns a number between 0 and 6.
  int previousWeekday(int weekday) {
    if (weekday < 0 || weekday > 6) throw Error();
    return weekday > 0 ? weekday - 1 : 6;
  }

  /// Returns a [String] corresponding to the date of [us], where [us] is an
  /// Epoch microsecond. If [asDicom] is _true_ the returned [String]
  /// has the DICOM format (_yyyymmdd_); otherwise, it has the
  /// Internet format (_yyyy-mm-dd_).
  /// Returns _Null_ if [us] is _NOT_ a microsecond in _this_ Epoch;
  String microsecondToDateString(int us, {bool asDicom = true}) =>
      isValidMicroseconds(us)
          ? dayToString(us ~/ kMicrosecondsPerDay, asDicom: asDicom)
          : null;

  /// Returns _true_ if [us] is a valid Epoch microsecond.
  bool isValidTimeMicroseconds(int us) => us >= 0 && us <= kMicrosecondsPerDay;

  /// Returns _true_ if [us] is _NOT_ a valid Epoch microsecond.
  bool isNotValidTimeMicroseconds(int us) => !isValidTimeMicroseconds(us);

  /// Returns a [String] corresponding to the time of [us] if valid;
  /// otherwise _null_.
  String microsecondToTimeString(int us, {bool asDicom = true}) =>
      isValidMicroseconds(us) ? timeToString(us % kMicrosecondsPerDay) : null;

  /// Returns a [String] corresponding to the [time] if valid;
  /// otherwise _null_. [time] must be in the
  /// range 0 <= [time] < [kMicrosecondsPerDay].  If [asDicom]
  /// is _true_ the format is 'hhmmss.ffffff'; otherwise the format is
  /// 'hh:mm:ss.ffffff'. If [us] [isNotValidTimeMicroseconds] returns _null_.
  String timeToString(int time, {bool asDicom = true}) {
    if (isNotValidTimeMicroseconds(time)) return null;
    final h = _digits2(time ~/ kMicrosecondsPerHour);
    final m = _digits2((time ~/ kMicrosecondsPerMinute) % kMicrosecondsPerHour);
    final s =
        _digits2((time ~/ kMicrosecondsPerSecond) % kMicrosecondsPerMinute);
    final ms = _digits3(
        (time ~/ kMicrosecondsPerMillisecond) % kMicrosecondsPerSecond);
    final us =
        _digits3((time ~/ kMicrosecondsPerHour) % kMicrosecondsPerMillisecond);
    return asDicom ? '$h$m$s.$ms$us' : '$h:$m:$s.$ms$us';
  }

  /// Returns a [String] corresponding to the DICOM DateTime if [us]
  /// valid for _this_ Epoch; otherwise _null_.   If [asDicom]
  /// is _true_ the format is 'hhmmss.ffffff'; otherwise the format is
  /// 'hh:mm:ss.ffffff'. If [us] [isNotValidTimeMicroseconds] returns _null_.
  String microsecondToDateTimeString(int us, {bool asDicom = true}) {
    final date = microsecondToDateString(us, asDicom: asDicom);
    final time = microsecondToTimeString(us, asDicom: asDicom);
    return asDicom ? '$date$time' : '${date}T$time';
  }

  /// Returns a [String] corresponding to _this_. If [asDicom] is _true_
  /// the format is 'yyyymmdd'; otherwise the format is 'yyyy-mm-dd'.
  static String dayToString(int day, {bool asDicom = true}) {
    final dt = dayToDate(day);
    final yy = _digits4(dt.year);
    final mm = _digits2(dt.month);
    final dd = _digits2(dt.day);
    return asDicom ? '$yy$mm$dd' : '$yy-$mm-$dd';
  }

  /// Returns a 4 digit [String], left padded with '0' if necessary.
  static String _digits4(int n) {
    if (n > 9999) return null;
    if (n >= 1000) return '$n';
    if (n >= 100) return '0$n';
    if (n >= 10) return '00$n';
    return '000$n';
  }

  /// Returns a 4 digit [String], left padded with '0' if necessary.
  static String _digits3(int n) {
    if (n > 999) return null;
    if (n >= 100) return '$n';
    if (n >= 10) return '0$n';
    return '00$n';
  }

  /// Returns a 2 digit [String], left padded with '0' if necessary.
  static String _digits2(int n) {
    if (n > 99) return null;
    if (n >= 10) return '$n';
    return '0$n';
  }
}

bool _isValidMonth(int m) => _inRange(m, 1, 12);

// **** Internal Functions ****

bool _inRange(int v, int min, int max) => v != null && v >= min && v <= max;
