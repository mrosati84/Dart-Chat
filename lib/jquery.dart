// Copyright (c) 2016, Matteo Rosati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:js' as js;

///
/// This is a handy way to call jQuery from Dart. This makes possible to call
/// jQuery methods simply calling:
/// jQuery.callMethod('methodName', ['parameterName']);
/// When jQuery method chaining is needed though, we prefer to call the JS
/// interop this way:
///
/// context
///    .callMethod('jQuery', ['#nick-modal'])
///    .callMethod('modal', ['hide']);
///
var jQuery = js.context['jQuery'];
