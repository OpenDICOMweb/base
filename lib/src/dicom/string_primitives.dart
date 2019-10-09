// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// See the AUTHORS file for contributors.
//
import 'package:charcode/ascii.dart';
import 'package:constants/src/string/string_primitives.dart';

/// Returns true if [c] is a valid DICOM String character code.
bool isDcmChar(int c) => c >= $space && c < $del && c != $backslash;

/// Returns true if [c] is a valid DICOM Text character code.
bool isDcmTextChar(int c) => c >= $space && c < $del;

/// Returns true if [c] is a valid DICOM Code String character code.
bool isDcmCodeStringChar(int c) =>
    isUppercaseChar(c) || isDigitChar(c) || c == $space || c == $underscore;
