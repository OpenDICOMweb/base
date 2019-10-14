//  Copyright (c) 2016, 2017, 2018,
//  Poplar Hill Informatics and the American College of Radiology
//  All rights reserved.
//  Use of this source code is governed by the open source license
//  that can be found in the odw/LICENSE file.
//  Primary Author: Jim Philbin <jfphilbin@gmail.edu>
//  See the AUTHORS file for other contributors.
//
import 'dart:io';
import 'package:constants/src/integer/hexadecimal.dart';
import 'package:constants/src/dicom/vr_base.dart';

// ignore_for_file: public_member_api_docs
// ignore_for_file: prefer_void_to_null

class InvalidVRError extends Error {
  String message;
  int vrIndex;
  int correctVR;
  Object tag;

  InvalidVRError(this.message, this.vrIndex, this.correctVR, [this.tag]);

  @override
  String toString() => _msg(tag, vrIndex);

  static String _msg(Object tag, int vrIndex) {
    final vr = vrIdFromIndex(vrIndex);
    return 'Error: Invalid VR (Value Representation) "$vr" for $tag';
  }
}

String _vrIndexErrorMsg(String type, int bad, int good, [Object tag]) {
  final sBad = '${vrIdFromIndex(good)}($bad)';
  final sGood = '${vrIdFromIndex(bad)}($good)';
  return _vrErrorMsg(type, sBad, sGood, tag);
}

String _vrCodeErrorMsg(String type, int bad, int good, [Object tag]) {
  final sBad = '${vrIdFromCode(bad)}(${hex16(bad)})';
  final sGood = '${vrIdFromCode(good)}(${hex16(bad)})';
  return _vrErrorMsg(type, sBad, sGood, tag);
}

String _vrErrorMsg(String type, String bad, String good, [Object tag]) {
  final t = (tag == null) ? '' : '$tag';
  return 'Error: Invalid $type $bad correct $good $t';
}

void _doError(int bad, int good, Object tag, String msg) {
  stderr.writeln(msg);
  throw InvalidVRError(msg, bad, good, tag);
}

Null badVRIndex(int badIndex, int goodIndex, [Object tag]) {
  final msg = _vrIndexErrorMsg('Index', badIndex, goodIndex, tag);
  return _doError(badIndex, goodIndex, tag, msg);
}

bool invalidVRIndex(int badIndex, int goodIndex, [Object tag]) {
  badVRIndex(badIndex, goodIndex, tag);
  return false;
}

Null badVRCode(int badCode, int goodCode, [Object tag]) {
  final msg = _vrCodeErrorMsg('Code', badCode, goodCode, tag);
  return _doError(badCode, goodCode, tag, msg);
}

bool invalidVRCode(int badCode, int goodCode, [Object tag]) {
  badVRCode(badCode, goodCode, tag);
  return false;
}
