// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// See the AUTHORS file for contributors.
//
import 'package:base/src/integer/hexadecimal.dart';


/// Returns a [String] in DICOM Tag Code format, e.g. (gggg,eeee),
/// corresponding to the Tag [code].
String dcm(int code) {
  assert(code >= 0 && code <= 0xFFFFFFFF, 'code: $code');
  return '(${hex16(code >> 16)},${hex16(code & 0xFFFF)})';
}

@Deprecated('Use dcm() instead')
/// Returns a [String] in DICOM Tag Code format, e.g. (gggg,eeee),
/// corresponding to the Tag [code].
String toDcm(int code) => dcm(code);
