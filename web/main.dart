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

///
/// Used to set the nickname in the chat.
/// [e] is the form submit DOM event.
/// Nickname can be a default one if the user does not provide one to use.
///
String handleNickFormSubmit(Event e, JsObject context, InputElement nickInput) {
  String nick = 'Anonymous user';
  e.preventDefault();

  if (nickInput.value.trim().isNotEmpty) {
    nick = nickInput.value.trim();
  }

  // Hide the modal, we have a nickname
  context
      .callMethod('jQuery', ['#nick-modal'])
      .callMethod('modal', ['hide']);

  return nick;
}

void main() {
  String nick;

  // Open the modal window
  context.callMethod('jQuery', ['#nick-modal'])
      .callMethod('modal', []);

  // Bind the modal close event. We want to init the websocket only once the
  // modal is closed (and user has a nickname).
  // Resulting JS is this:
  // jQuery('#nick-modal').on('hidden.bs.modal', <<initWebsocket>>);
  // NOTE: initWebsocket is though not exported to JS context.
  context.callMethod('jQuery', ['#nick-modal'])
      .callMethod('on', ['hidden.bs.modal', (JsObject obj) {
        initWebsocket();
      }]);

  // Handle submission of nickname form
  nickForm.onSubmit.listen((e) {
    nick = handleNickFormSubmit(e, context, nickInput);
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
