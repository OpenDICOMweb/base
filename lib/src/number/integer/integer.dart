//  Copyright (c) 2016, 2017, 2018,
//  Poplar Hill Informatics and the American College of Radiology
//  All rights reserved.
//  Use of this source code is governed by the open source license
//  that can be found in the odw/LICENSE file.
//  Primary Author: Jim Philbin <jfphilbin@gmail.edu>
//  See the AUTHORS file for other contributors.
//
import 'dart:typed_data';

/// Empty IntList
const List<int> kEmptyIntList = <int>[];

/// Empty Uint8List
final Int8List kEmptyInt8List = Int8List(0);
/// Empty Int16List
final Int16List kEmptyInt16List = Int16List(0);
/// Empty Int32List
final Int32List kEmptyInt32List = Int32List(0);
/// Empty Int64List
final Int64List kEmptyInt64List = Int64List(0);

/// Empty Uint8List
final Uint8List kEmptyUint8List = Uint8List(0);
/// Empty Uint16List
final Uint16List kEmptyUint16List = Uint16List(0);
/// Empty Uint32List
final Uint32List kEmptyUint32List = Uint32List(0);
/// Empty Uint64List
final Uint64List kEmptyUint64List = Uint64List(0);
/// Empty ByteData
final ByteData kEmptyByteData = ByteData(0);

/// Checks that vfLength (vfl) is in range and the right size, based on the
/// element size (eSize).
bool isValidLength(int length, int max,
    {bool Function(int length, int max) onError}) {
  if (length >= 0 && length <= max) return true;
  return onError(length, max);
}

/// Returns _true_ if '''v >= min && v <= max'''.
bool inRange(int v, int min, int max) => v >= min && v <= max;

/// Returns _true_ if [n] < [min] or [n] > [max].
bool notInRange(int n, int min, int max) => !inRange(n, min, max);

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

