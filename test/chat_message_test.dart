@TestOn("vm")

import 'package:test/test.dart';

/// The class to be tested
import '../lib/classes/chat_message.dart';

const String jsonChatMessage = '{"nick": "My nick", "message": "My message"}';

void main() {
  test("String representation of a chat message is JSON", () {
    ChatMessage message = new ChatMessage('My nick', 'My message');
    expect(message.toString(), equals(jsonChatMessage));
  });

  test("I can create a chat message from JSON", () {
    ChatMessage message = new ChatMessage.fromJSON(jsonChatMessage);
    expect(message.nick, equals('My nick'));
    expect(message.message, equals('My message'));
  });
}
