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

/// that has at most 16 characters.
String floatToString(double v) {
  const precision = 10;
  var s = v.toString();
  if (s.length > 16) {
    for (var i = precision; i > 0; i--) {
      s = v.toStringAsPrecision(i);
      if (s.length <= 16) break;
    }
  }
  assert(s.length <= 16, '"$s" exceeds max DS length of 16');
  return s;
}


