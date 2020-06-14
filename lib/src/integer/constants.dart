//  Copyright (c) 2016, 2017, 2018,
//  Poplar Hill Informatics and the American College of Radiology
//  All rights reserved.
//  Use of this source code is governed by the open source license
//  that can be found in the odw/LICENSE file.
//  Primary Author: Jim Philbin <jfphilbin@gmail.edu>
//  See the AUTHORS file for other contributors.
//
import 'dart:typed_data';

// ignore_for_file: public_member_api_docs

// Urgent delete
//const int kMin64BitInt = 0x8000000000000000;
//const int kMax64BitInt = 0x7FFFFFFFFFFFFFFF;

/// The minimum values of a signed 8-bit integer.
const int kInt8Min = -(1 << (8 - 1));

/// The maximum values of a signed 8-bit integer.
const int kInt8Max = (1 << (8 - 1)) - 1;

/// The minimum values of a signed 16-bit integer.
const int kInt16Min = -(1 << (16 - 1));

/// The maximum values of a signed 16-bit integer.
const int kInt16Max = (1 << (16 - 1)) - 1;

/// The minimum values of a signed 32-bit integer.
const int kInt32Min = -(1 << (32 - 1));

/// The maximum values of a signed 32-bit integer.
const int kInt32Max = (1 << (32 - 1)) - 1;

/// The minimum values of an unboxed, signed 64-bit integer.
const int kInt64Min = -0x8000000000000000;

/// The maximum values of an unboxed, signed 64-bit integer.
const int kInt64Max = 0x7FFFFFFFFFFFFFFF;

/// The minimum values of a unsigned 16-bit integer.
const int kUint8Min = 0;

/// The maximum values of a unsigned 16-bit integer.
const int kUint8Max = 0xFF;

/// The minimum values of a unsigned 32-bit integer.
const int kUint16Min = 0;

/// The maximum values of an unsigned 16-bit integer (2^32).
const int kUint16Max = 0xFFFF;

/// The minimum values of a unsigned 32-bit integer.
const int kUint32Min = 0;

/// The maximum values of an unsigned 32-bit integer (2^32).
const int kUint32Max = 0xFFFFFFFF;

/// The minimum values of an unboxed, unsigned 64-bit integer.
const int kUint64Min = 0;

/// The maximum values of an unboxed, unsigned 64-bit integer (2^32).
const int kUint64Max = kInt64Max;

const List<int> kEmptyIntList = <int>[];

final Int8List kEmptyInt8List = Int8List(0);
final Int16List kEmptyInt16List = Int16List(0);
final Int32List kEmptyInt32List = Int32List(0);
final Int64List kEmptyInt64List = Int64List(0);

final Uint8List kEmptyUint8List = Uint8List(0);
final Uint16List kEmptyUint16List = Uint16List(0);
final Uint32List kEmptyUint32List = Uint32List(0);
final Uint64List kEmptyUint64List = Uint64List(0);

const List<double> kEmptyDoubleList = <double>[];
final Float32List kEmptyFloat32List = Float32List(0);
final Float64List kEmptyFloat64List = Float64List(0);

final ByteData kEmptyByteData = ByteData(0);


// TODO: eventually remove these
/// The minimum integer values, in Dart, that can be stored without boxing.
//const int kDartMinSMInt = -4611686018427387904;

/// The maximum integer values, in Dart, that can be stored without boxing.
//const int kDartMaxSMInt = 4611686018427387903;

/// The maximum unsigned integer values, in Dart, that can be stored
/// without boxing.
//const int kDartMaxSMUint = 0x3FFFFFFFFFFFFFFF;

/* Urgent Decide if we should have primitive functions
/// Return [value], if it satisfies [min] <= [value] <= [max];
/// otherwise, throws a [RangeError].
int checkRange(int value, int min, int max, {bool throwOnError = false}) {
  if (value < min || value > max) {
    return throwOnError
        ? throw RangeError('$value is not in range $min to $max')
        : null;
  }
  return value;
}

/// Returns _true_ if [s] is a valid unsigned integer [String].
bool isValidUintString(String s,
        [int start = 0,
        int end,
        Issues issues,
        int minLength = 0,
        int maxLength = 20]) =>
    tryParseUint(s,
        start: start,
        end: end,
        issues: issues,
        minLength: minLength,
        maxLength: maxLength) !=
    null;

/// Returns _true_ if [s] is a valid signed integer [String].
bool isValidIntString(String s,
        [int start = 0,
        int end,
        Issues issues,
        int minLength = 1,
        int maxLength = 20]) =>
    tryParseInt(s, start, end, issues, minLength, maxLength) != null;

/// Returns the hash of a DICOM IS Element values
String hashIntegerString(String s, {Issues issues}) {
  final i = tryParseInt(s);
  if (i == null || i < kMinIntegerStringValue || i > kMaxIntegerStringValue)
    return parseError('Invalid Integer String: $s', issues);
  final sign = (i.isOdd) ? -1 : 1;
  final hash = sign * Global.rng.nextInt(kMaxIntegerStringHashValue);
  return hash.toString();
}

List<String> hashIntegerStringList(List<String> sList, {Issues issues}) =>
    sList.map((s) => hashIntegerString(s, issues: issues));
*/
