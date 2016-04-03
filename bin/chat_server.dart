// Copyright (c) 2016, Matteo Rosati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:async';
import 'package:chat/constants.dart';
import 'package:chat/logger.dart';
import 'package:chat/classes/chat_client.dart';

///
/// This is the server main function.
/// The server is used only to dispatch chat messages across all the clients
/// connected.
///
main() {
  setupLogger();

  runZoned(() async {
    var server = await HttpServer.bind(SERVER_ADDRESS, SERVER_PORT);

    log.fine("Server bind to ws://$SERVER_ADDRESS:$SERVER_PORT");

    await for (var req in server) {
      if (req.uri.path == WEBSOCKET_PATH) {
        // Upgrade a HttpRequest to a WebSocket connection.
        var socket = await WebSocketTransformer.upgrade(req);

        // Client has connected, we add it to the list of connected clients
        log.fine("Client connected");
        ChatClient client = new ChatClient(socket)..addToClientsList();

        // Incoming socket message.
        socket.listen((message) {
          // This is how we broadcast messages to all connected clients
          chatClientList.forEach((client) {
            client.socket.add(message);
          });
        }, onDone: () {
          // Client disconnected (i.e. closed the browser, refreshed the page)
          log.fine("Client disconnected");
          client.removeFromClientsList();
        }, onError: () {
          log.severe("An error occurred handling websocket");
          client.removeFromClientsList();
        });
      }
    }
  }, onError: (e) => log.severe(e));
}
