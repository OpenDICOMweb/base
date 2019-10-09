// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// See the AUTHORS file for contributors.
//
import 'package:charcode/ascii.dart';

/// Returns true if [c] is an uppercase ASCII character.
bool isUppercaseChar(int c) => c >= $A && c <= $Z;

/// Returns true if [c] is a valid ASCII digit.
bool isDigitChar(int c) =>
    c >= $0 && c < $backslash || c > $backslash && c < $del;


