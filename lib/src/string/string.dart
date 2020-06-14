//  Copyright (c) 2016, 2017, 2018,
//  Poplar Hill Informatics and the American College of Radiology
//  All rights reserved.
//  Use of this source code is governed by the open source license
//  that can be found in the odw/LICENSE file.
//  Primary Author: Jim Philbin <jfphilbin@gmail.edu>
//  See the AUTHORS file for other contributors.
//
import 'dart:convert';
import 'dart:typed_data';

import 'package:constants/src/character/ascii.dart';
import 'package:constants/src/integer/constants.dart';

// ignore_for_file: public_member_api_docs

const List<String> kEmptyStringList = <String>[];

bool isAllBlanks(String s, int start, int end) {
  for (var i = start; i < s.length; i++)
    if (s.codeUnitAt(i) != kSpace) return false;
  return true;
}

// **** This file contains low-level [String] functions

/// Returns a [String] containing [count] _space_ (' ') characters.
String spaces(int count) => ''.padRight(count);

/// Returns an [Iterable] of [s], where [s] is split at the
/// separator and then each component of the [Iterable] has
/// the specified whitespace trimmed.
Iterable<String> splitTrim(String s, String separator, [End trim]) =>
    s.split(separator).map((s) => trimWhitespace(s, trim));

String removeNullPadding(String s) {
  final lastIndex = s.length - 1;
  return (s.codeUnitAt(lastIndex) == kNull) ? s.substring(0, lastIndex) : s;
}

/// The type of whitespace trimming.
enum Trim { leading, trailing, both, none }

String trimmer(String s, Trim trim) {
  if (s == null || s.isEmpty || trim == Trim.none) return s;
  switch (trim) {
    case Trim.trailing:
      return s.trimRight();
    case Trim.both:
      return s.trim();
    case Trim.leading:
      return s.trimLeft();
    default:
      return _badStringTrim(trim);
  }
}

String _badStringTrim(Trim trim) => throw Exception('Trim error; $trim');

/// Specifies whether padding is allowed on the left-end, right-end,
/// or both-ends.
enum End { left, right, both }

/// Returns a [String] with the specified whitespace (see [String.trim])
/// removed. If [end] is not specified, it defaults to [End.right].
String trimWhitespace(String s, [End end]) {
  end ??= End.right;
  if (end == End.right) return s.trimRight();
  if (end == End.both) return s.trim();
  if (end == End.left) return s.trimLeft();
  return s;
}

Uint8List stringToUint8List(String s, {bool isAscii = false}) {
  if (s == null) return null;
  if (s.isEmpty) return kEmptyUint8List;
  return isAscii ? ascii.encode(s) : utf8.encode(s);
}

ByteData stringToByteData(String s, {bool isAscii = false}) {
  if (s == null) return null;
  final bList = stringToUint8List(s, isAscii: isAscii);
  return bList.buffer.asByteData();
}

/*
bool isDcmString(String s, int max,
    {bool allowLeading = true, bool allowBlank = true}) {
  final len = (s.length < max) ? s.length : max;
  if (allowInvalidCharsInStrings) return true;
  return isFilteredString(s, 0, len, isDcmStringChar,
      allowLeadingSpaces: allowLeading,
      allowTrailingSpaces: true,
      allowBlank: allowBlank);
}

bool isNotDcmString(String s, int max, {bool allowLeading = true}) =>
    !isDcmString(s, max, allowLeading: allowLeading);

bool isDcmText(String s, int max) {
  final len = (s.length < max) ? s.length : max;
  return isFilteredString(s, 0, len, isDcmTextChar,
      allowLeadingSpaces: false, allowTrailingSpaces: true);
}

bool isNotDcmText(String s, int max) => !isDcmText(s, max);
*/

// Improvement: Handle escape sequences
bool isFilteredString(String s, int min, int max, bool Function(int) filter,
    {bool allowLeadingSpaces = false,
    bool allowTrailingSpaces = false,
    bool allowBlank = true}) {
  if (s.isEmpty) return true;
  if (s.length < min || s.length > max) return false;

  var i = 0;
  if (allowLeadingSpaces)
    for (; i < s.length; i++) if (s.codeUnitAt(i) != kSpace) break;

  if (i >= s.length) return allowBlank;

  for (var j = 0; j < s.length; j++) {
    if (!filter(s.codeUnitAt(j))) return false;
  }
  return true;
}

bool isNotFilteredString(String s, int min, int max, bool Function(int) filter,
        {bool allowLeading = false,
        bool allowTrailing = false,
        bool allowBlank = true}) =>
    !isFilteredString(s, min, max, filter,
        allowLeadingSpaces: allowLeading, allowTrailingSpaces: allowTrailing);