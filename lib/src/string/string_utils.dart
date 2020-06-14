//  Copyright (c) 2016, 2017, 2018,
//  Poplar Hill Informatics and the American College of Radiology
//  All rights reserved.
//  Use of this source code is governed by the open source license
//  that can be found in the odw/LICENSE file.
//  Primary Author: Jim Philbin <jfphilbin@gmail.edu>
//  See the AUTHORS file for other contributors.
//
import 'dart:convert' as cvt;
import 'dart:typed_data';

import 'package:constants/src/integer/constants.dart';
import 'package:constants/src/string/string.dart';

// ignore_for_file: public_member_api_docs

// **** This file contains low-level [String] [List] utility functions

// Urgent: find out which of this are really used and which are duplicated
/// Returns the number of code points, plus separators, plus padding.
int _stringListLength(Iterable<String> sList,
    {String separator = '\\', bool pad = true}) {
  if (sList.isEmpty) return 0;
  var len = sList.fold(0, _combineSLength);
  len += sList.length - 1;
  if (len.isOdd && pad) len++;
  return len;
}

int _combineSLength(int v, String s) => v + s.length;

// TODO: unit test
int stringListLength(Iterable<String> sList,
        {String separator = '\\', bool pad = true}) =>
    (sList.isEmpty) ? 0 : _stringListLength(sList, pad: pad);

Iterable<String> uppercase(List<String> vList) =>
    vList.map((s) => s.toUpperCase());

/// Returns a [String] created from [sList], where [separator] separates
/// each component in the resulting [String].
String stringListToString(List<String> sList, [String separator = '\\']) {
  if (sList == null) return null;
  if (sList.isEmpty) return '';
  return sList.length == 1 ? sList[0] : sList.join('\\');
}

/// Returns a [Uint8List] encoding of [sList].
Uint8List stringListToUint8List(List<String> sList,
    {int maxLength,
    bool isAscii = false,
    String separator = '\\',
    int padChar}) {
  final s = stringListToString(sList);
  if (s == null || s.length > maxLength) return null;
  return stringToUint8List(s, isAscii: isAscii);
}

/// Returns a [ByteData] encoding of [sList].
/// Returns a [Uint8List] corresponding to a binary Value Field.
ByteData stringListToByteData(List<String> sList,
    {int maxLength, bool isAscii = false, String separator = '\\'}) {
  if (sList == null) return null;
  final bList = stringListToUint8List(sList,
      maxLength: maxLength, isAscii: isAscii, separator: separator);
  return (bList == null) ? null : bList.buffer.asByteData();
}

List<String> stringListFromTypedData(TypedData td, int maxLength,
    {bool isAscii = true}) {
  if (td.lengthInBytes == 0) return kEmptyStringList;
  if (td.lengthInBytes > maxLength) return _tdLengthError(td, maxLength);
  final s = typedDataToString(td, isAscii: isAscii);
  return s.split('\\');
}

List<String> _tdLengthError(TypedData td, int maxLength) =>
    throw Exception('$td with length ${td.lengthInBytes} is greater'
        'than maximum length of $maxLength');

/// Converts the bytes in [valueField] to a [String].
/// If [isAscii] is _true_ [valueField] is converted to ASCII;
/// otherwise, UTF8.
/// If [allowInvalid] is _true_ invalid characters are allow
/// in the returned [String]; otherwise, an Error is thrown.
String typedDataToString(TypedData valueField,
    {bool isAscii = false, bool allowInvalid = true}) {
  final vfBytes = valueField.buffer
      .asUint8List(valueField.offsetInBytes, valueField.lengthInBytes);
  return isAscii
      ? cvt.ascii.decode(vfBytes, allowInvalid: allowInvalid)
      : cvt.utf8.decode(vfBytes, allowMalformed: allowInvalid);
}

List<String> textListFromBytes(TypedData vfBytes,
        {int maxLength, bool isAscii = true}) =>
    textListFromTypedData(vfBytes, maxLength: maxLength, isAscii: isAscii);

List<String> textListFromTypedData(TypedData td,
    {int maxLength, bool isAscii = true}) {
  if (td == null) return null;
  if (td.lengthInBytes == 0) return kEmptyStringList;
  if (td.lengthInBytes > maxLength) return _tdLengthError(td, maxLength);
  return <String>[typedDataToString(td, isAscii: isAscii)];
}

/// Returns a [Uint8List] corresponding to a binary Value Field.
/// If
Uint8List textListToUint8List(Iterable<String> values, int maxVFLength) {
  if (values.isEmpty) return kEmptyUint8List;
  if (values.length == 1) {
    final s = values.elementAt(0);
    if (s == null) return null;
    if (s.isEmpty) return kEmptyUint8List;
    return stringToUint8List(s, isAscii: false);
  }
  return null;
}
