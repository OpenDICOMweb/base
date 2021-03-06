//  Copyright (c) 2016, 2017, 2018,
//  Poplar Hill Informatics and the American College of Radiology
//  All rights reserved.
//  Use of this source code is governed by the open source license
//  that can be found in the odw/LICENSE file.
//  Primary Author: Jim Philbin <jfphilbin@gmail.edu>
//  See the AUTHORS file for other contributors.
//
import 'package:constants/src/integer_constants.dart';

// ignore_for_file: public_member_api_docs

/// The naming convention is that the plural form is a total, and the singular
/// form is a component. For example the minimum microsecond corresponds to
/// the most negative Dart Small Integer + 1.

// **** Unix Epoch Constants

// TODO: before V0.9.0 decide what these values should be.
//const int kDefaultMinYear = -10000 - 1970;
const int kDefaultMinYear = 1900;
const int kDefaultMaxYear = 2050;

const int kInvalidEpochMicroseconds = kInt64Min;

// These are the upper and lower bounds for Epoch microseconds for the system.
// [kMin64BitInt] is the error values for Dates and Times.
const int kEpochMicrosecondsErrorValue = kInt64Min;
const int kAbsoluteMinEpochMicroseconds = kInt64Min + 1;
const int kAbsoluteMaxEpochMicroseconds = kInt64Max;
const int kAbsoluteMinEpochMicrosecondsUTC =
    kAbsoluteMinEpochMicroseconds + kMinTimeZoneMicroseconds;
const int kAbsoluteMaxEpochMicrosecondsUTC =
    kAbsoluteMaxEpochMicroseconds - kMaxTimeZoneMicroseconds;

// **** Date Constants
// These constants are computed in core/bin/min_max_epoch_day.dart
const int kAbsoluteMinEpochDay = -53375995;
const int kAbsoluteMaxEpochDay = 52656527;
const int kEpochDayZero = 0;
const int kEpochDayZeroInMicroseconds = 0;
const int kEpochDayZeroWeekday = kThursday;

// The number of days between 0000-03-01 (March 1, 0000) and
// Epoch Day 0 (January 1, 1970). This number is used to calculate
// the Epoch Day upper bound, which is the most positive Dart small
// integer ([SMI]) minus the number of days from 0000-03-01 and
// Epoch Day Zero (1970-01-01).
const int kEpochDayFor00000301 = -719468;

/// The Epoch Day for 1960-01-01.
const int k1960InEpochDays = -3653;
const int k1960InEpochMicroseconds = -3653 * kMicrosecondsPerDay;

/// The American College of Radiology _baseline_ date
/// for de-identifying Dates.
const int kACRBaselineDay = k1960InEpochDays;
const int kACRBaselineMicroseconds = k1960InEpochMicroseconds;

const List<String> weekdayNames = <String>[
  'Sunday', 'Monday', 'Tuesday', 'Wednesday',
  'Thursday', 'Friday', 'Saturday' // no reformat
];

const int kSunday = 0;
const int kMonday = 1;
const int kTuesday = 2;
const int kWednesday = 3;
const int kThursday = 4;
const int kFriday = 5;
const int kSaturday = 6;

const List<int> daysInCommonYearMonth = <int>[
  0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 //keep
];

const List<int> daysInLeapYearMonth = <int>[
  0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 //keep
];

// **** Time Constants
const int kMicrosecondsPerMillisecond = 1000;
const int kMillisecondsPerSecond = 1000;
const int kSecondsPerMinute = 60;
const int kMinutesPerHour = 60;
const int kHoursPerDay = 24;

const int kMillisecondsPerMinute = kSecondsPerMinute * kMillisecondsPerSecond;
const int kMillisecondsPerHour = kSecondsPerHour * kMillisecondsPerSecond;
const int kMillisecondsPerDay = kSecondsPerDay * kMillisecondsPerSecond;
const int kSecondsPerHour = kMinutesPerHour * kSecondsPerMinute;
const int kSecondsPerDay = kMinutesPerDay * kSecondsPerMinute;
const int kMinutesPerDay = kHoursPerDay * kMinutesPerHour;

const int kMicrosecondsPerSecond =
    kMillisecondsPerSecond * kMicrosecondsPerMillisecond;
const int kMicrosecondsPerMinute =
    kMillisecondsPerMinute * kMicrosecondsPerMillisecond;
const int kMicrosecondsPerHour =
    kMillisecondsPerHour * kMicrosecondsPerMillisecond;
const int kMicrosecondsPerDay =
    kMillisecondsPerDay * kMicrosecondsPerMillisecond;
const int kMicrosecondsPerYear = kMillisecondsPerDay * 365;

// **** Time Zone Constants

/// The minimum time zone hour values.
const int kMinTimeZoneHour = -12;

/// The maximum time zone hour values.
const int kMaxTimeZoneHour = 14;

/// The minimum values for a time zone in minutes.
const int kMinTimeZoneMinutes = kMinTimeZoneHour * 60;

/// The maximum values for a time zone in microseconds.
const int kMaxTimeZoneMinutes = kMaxTimeZoneHour * 60;

/// The minimum values for a time zone in microseconds.
const int kMinTimeZoneMicroseconds =
    kMinTimeZoneMinutes * kMicrosecondsPerMinute;

/// The maximum values for a time zone in microseconds.
const int kMaxTimeZoneMicroseconds =
    kMaxTimeZoneMinutes * kMicrosecondsPerMinute;

const int kUSEastTimeZone = -5 * kMinutesPerHour;
const int kUSCentralTimeZone = -6 * kMinutesPerHour;
const int kUSMountainTimeZone = -7 * kMinutesPerHour;
const int kUSPacificTimeZone = -8 * kMinutesPerHour;

const int kDaysInWeek = 7;
