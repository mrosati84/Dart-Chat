// Copyright (c) 2016, Matteo Rosati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'package:chat/logger.dart';

// Keep track of all the registered clients in a list
List<ChatClient> chatClientList = new List<ChatClient>();

///
/// This class represents a [ChatClient]
/// client using the chat.
///
class ChatClient {
  WebSocket _socket; // keep track of all the connected sockets

  ChatClient(WebSocket socket) {
    this._socket = socket;
  }

  ///
  /// getter for the [_socket] attribute
  ///
  WebSocket get socket => this._socket;

  void addToClientsList() {
    chatClientList.add(this);
    log.fine(
        "Client added to list. Currently ${chatClientList.length} clients are connected");
  }

  void removeFromClientsList() {
    chatClientList.remove(this);
    log.fine(
        "Client removed from list. Currently ${chatClientList.length} clients are connected");
  }
}
