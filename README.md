# Dart Chat

![Travis build status](https://travis-ci.org/mrosati84/Dart-Chat.svg?branch=master)

This project demonstrates how to use Google Dartlang on both client and server to build a realtime websocket chat
application.

## Requirements

To run this project you need the Dart SDK and best but not required either WebStorm or PHPStom with the Dart plugin
installed.

* [Dart SDK](https://www.dartlang.org/downloads/)
* [PHPStorm IDE](https://www.jetbrains.com/phpstorm/download/)
* [WebStorm IDE](https://www.jetbrains.com/webstorm/download/)

## Building and running the project

First thing needed is to download all the Dart libraries dependencies. We will use [Pub](http://pub.dartlang.org) for
this:

```
$ pub get
Resolving dependencies...
```

Once all the dependencies are installed within the project root, from your terminal run:

```
$ pub serve
Loading source assets...
Loading dart_to_js_script_rewriter transformers...
Serving chat web on http://localhost:8080
Build completed successfully
```

This will serve the frontend application. To run the server, use this command:

```
$ dart bin/chat_server.dart
FINE: 2016-04-04 00:02:29.211357: Server bind to ws://0.0.0.0:4040
```

You can now visit [http://localhost:8080](http://localhost:8080) using [Dartium](https://www.dartlang.org/tools/dartium/) (faster, won't need Javascript
compilation) or either Chrome (will be slower, Dart code will be compiled on the fly in Javascript).

Default ports for web and server are respectively `8080` and `4040`.

## TODO

* unit tests
* a bit of frontend sugar
