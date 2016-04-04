@TestOn("vm")

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'dart:io';

/// The class to be tested
import '../lib/classes/chat_client.dart';

/// Mock class to use in [ChatClient] class.
class MockWebSocket extends Mock implements WebSocket {}

void main() {
  test("A chat client can be added and removed from clients list", () {
    ChatClient client = new ChatClient(new MockWebSocket());
    client.addToClientsList();
    expect(chatClientList.length, equals(1));

    client.removeFromClientsList();
    expect(chatClientList.length, equals(0));
  });
}
