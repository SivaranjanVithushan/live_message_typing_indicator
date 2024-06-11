// main.dart
import 'package:flutter/material.dart';
import 'chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Typing Indicator Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TypingIndicatorTest(),
    );
  }
}

class TypingIndicatorTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Typing Indicator Test'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatScreen(
              userId: 'oxopiVwg',
              otherUserId: 'kC17Vge2',
            ),
          ),
          Expanded(
            child: ChatScreen(
              userId: 'kC17Vge2',
              otherUserId: 'oxopiVwg',
            ),
          ),
        ],
      ),
    );
  }
}
