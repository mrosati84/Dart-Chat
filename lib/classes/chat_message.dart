// Copyright (c) 2016, Matteo Rosati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

///
/// Represents a single message on the chat.
/// It contains two constructors, one plain, one
/// to be used with a JSON input.
///
class ChatMessage {
  String _nick;
  String _message;

  ChatMessage(this._nick, this._message);

  ///
  /// Uses [jsonMessage] to build the chat message
  ///
  ChatMessage.fromJSON(String jsonMessage) {
    Map decodedMessage = JSON.decode(jsonMessage);

    this._nick = decodedMessage['nick'];
    this._message = decodedMessage['message'];
  }

  String get nick => this._nick;
  String get message => this._message;

  ///
  /// Shorthand to convert a chat message to JSON.
  ///
  @override
  String toString() {
    HtmlEscape sanitizer = const HtmlEscape();
    return '{"nick": "${sanitizer.convert(this.nick)}", "message": "${sanitizer.convert(this.message)}"}';
  }
}
