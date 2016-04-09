// Copyright (c) 2016, Matteo Rosati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'constants.dart';

final Logger log = new Logger(LOGGER_NAME);

/// Set up the [Logger]
void setupLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
