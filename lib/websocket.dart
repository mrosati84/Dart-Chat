// Copyright (c) 2016, Matteo Rosati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'constants.dart';
import 'package:chat/jquery.dart';
import 'package:chat/classes/chat_message.dart';
import 'dart:async';

WebSocket websocket;
final DivElement messages = querySelector('#messages');

///
/// This function sets up the websocket connection
/// and assigns all the related events handlers.
/// [retrySeconds] parameter determines how many
/// seconds to wait before retry a new connection
/// after an error.
///
void initWebsocket([int retrySeconds = WEBSOCKET_RETRY_TIMEOUT]) {
  websocket = new WebSocket(WEBSOCKET_URI);
  var reconnectScheduled = false;

  ///
  /// Schedules a reconnection to the websocket.
  ///
  void scheduleReconnect() {
    if (!reconnectScheduled) {
      new Timer(new Duration(milliseconds: 1000 * retrySeconds),
          () => initWebsocket(retrySeconds * WEBSOCKET_RETRY_TIMEOUT));
    }

    reconnectScheduled = true;
  }

  websocket.onOpen.listen((e) {
    jQuery.callMethod('notify', ['Connected to websocket', 'success']);
  });

  websocket.onClose.listen((e) {
    jQuery.callMethod('notify', [
      'Websocket closed by server! Retrying in $retrySeconds seconds...',
      'error'
    ]);

    scheduleReconnect();
  });

  websocket.onError.listen((e) {
    jQuery.callMethod('notify', [
      'Error connecting to server! Retrying in $retrySeconds seconds...',
      'error'
    ]);
  });

  websocket.onMessage.listen((MessageEvent e) {
    ChatMessage message = new ChatMessage.fromJSON(e.data);
    messages.children.add(new ParagraphElement()
      ..innerHtml = '${message.nick}: ${message.message}');
  });
}
