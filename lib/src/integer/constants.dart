//  Copyright (c) 2016, 2017, 2018,
//  Poplar Hill Informatics and the American College of Radiology
//  All rights reserved.
//  Use of this source code is governed by the open source license
//  that can be found in the odw/LICENSE file.
//  Primary Author: Jim Philbin <jfphilbin@gmail.edu>
//  See the AUTHORS file for other contributors.
//

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

// TODO: eventually remove these
/// The minimum integer values, in Dart, that can be stored without boxing.
//const int kDartMinSMInt = -4611686018427387904;

/// The maximum integer values, in Dart, that can be stored without boxing.
//const int kDartMaxSMInt = 4611686018427387903;

/// The maximum unsigned integer values, in Dart, that can be stored
/// without boxing.
//const int kDartMaxSMUint = 0x3FFFFFFFFFFFFFFF;


