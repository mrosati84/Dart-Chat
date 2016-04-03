// Copyright (c) 2016, Matteo Rosati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:chat/constants.dart';
import 'package:chat/websocket.dart';
import 'package:chat/classes/chat_message.dart';
import 'dart:js';

final InputElement message = querySelector('#message');
final InputElement nickInput = querySelector('#nick');
final FormElement nickForm = querySelector('#nick-form');
final ButtonElement nickBtn = querySelector('#nick-btn');
String nick = 'Anonymous user';

///
/// [e] is the form submit DOM event.
/// Used to set the nickname in the chat.
/// Nickname can be a default one if the
/// user does not provide one to use.
///
String handleNickFormSubmit(e) {
  e.preventDefault();

  if (nickInput.value.trim().isNotEmpty) {
    nick = nickInput.value.trim();
  }

  // Hide the modal
  context
      .callMethod('jQuery', ['#nick-modal'])
      .callMethod('modal', ['hide']);

  return nick;
}

void main() {
  // Open the modal window
  context.callMethod('jQuery', ['#nick-modal'])
      .callMethod('modal', []);

  // Bind the modal close event.
  // We want to init the websocket
  // only once the modal is closed.
  context.callMethod('jQuery', ['#nick-modal'])
      .callMethod('on', ['hidden.bs.modal', (JsObject obj) {
        initWebsocket();
      }]);

  // Handle submission of nickname form
  nickForm.onSubmit.listen((e) {
    nick = handleNickFormSubmit(e);
  });

  // Handle chat message sending
  message.onKeyPress.listen((e) {
    if (e.keyCode == ENTER_KEY) {
      String message = (e.currentTarget as InputElement).value.trim();

      if (message.isNotEmpty) {
        // Empty the message input
        (e.currentTarget as InputElement).value = '';
        // Sent the message to the websocket
        websocket.sendString(new ChatMessage(nick, message).toString());
      }
    }
  });
}
