//  Copyright (c) 2016, 2017, 2018,
//  Poplar Hill Informatics and the American College of Radiology
//  All rights reserved.
//  Use of this source code is governed by the open source license
//  that can be found in the odw/LICENSE file.
//  Primary Author: Jim Philbin <jfphilbin@gmail.edu>
//  See the AUTHORS file for other contributors.
//

/// The value that indicates the length of an Element's
/// Value Field is undefined.
const kUndefinedLength = 0xFFFFFFFF - 1;

/// The maximum length of a Long Value Field.
const kMaxLongVF = kUndefinedLength - 1;

/// The maximum length of a Short Value Field
const kMaxShortVF = 0xFFFF;
