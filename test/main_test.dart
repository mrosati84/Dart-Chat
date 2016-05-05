@TestOn("phantomjs")

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'dart:html';
import 'dart:js';
import '../web/main.dart';

/// Mock class for DOM event
class MockEvent extends Mock implements Event {}

/// Mock class for HTML input element
class MockInput extends Mock implements InputElement {
  String value;
}

/// Mock class for js interop context
class MockContext extends Mock implements JsObject {}

MockEvent event;
MockInput input;
MockContext context;

const TEST_NICK = 'Test nick';
const DEFAULT_NICK = 'Anonymous user';

///
/// FIXME this test contains a lot of duplicated code
///

void main() {
  test("User can provide a nickname", () {
    event = new MockEvent();
    input = new MockInput();
    context = new MockContext();

    // Stub call to js interop context callMethod
    when(context.callMethod('jQuery', ['#nick-modal']))
        .thenReturn(context);
    expect(context.callMethod('jQuery', ['#nick-modal']), new isInstanceOf<JsObject>());

    // Pretend user has entered something in the form
    input.value = TEST_NICK;

    expect(handleNickFormSubmit(event, context, input), equals(TEST_NICK));

    // Verify preventDefault has been called on mock event
    verify(event.preventDefault());
  });

  test("If a user leaves nick empty, a default one is provided", () {
    event = new MockEvent();
    input = new MockInput();
    context = new MockContext();

    // Stub call to js interop context callMethod
    when(context.callMethod('jQuery', ['#nick-modal']))
        .thenReturn(context);
    expect(context.callMethod('jQuery', ['#nick-modal']), new isInstanceOf<JsObject>());

    input.value = '';

    expect(handleNickFormSubmit(event, context, input), equals(DEFAULT_NICK));

    // Verify preventDefault has been called on mock event
    verify(event.preventDefault());
  });
}