// chat_screen.dart
import 'package:ably_typing_indicator/typingIndicatorService.dart';
import 'package:flutter/material.dart';

import 'typing_indicator_widget.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String otherUserId;

  ChatScreen({required this.userId, required this.otherUserId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TypingIndicatorService _typingIndicatorService;
  bool _isTyping = false;
  String _typingUser = '';

  @override
  void initState() {
    super.initState();
    _typingIndicatorService = TypingIndicatorService(widget.userId);

    _typingIndicatorService.listenForTypingEvents((userId) {
      if (userId == widget.otherUserId) {
        setState(() {
          _isTyping = true;
          _typingUser = userId;
        });
        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            _isTyping = false;
          });
        });
      }
    });
  }

  void _onTextChanged(String text) {
    _typingIndicatorService.sendTypingEvent(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.otherUserId}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Your chat messages will go here
              ],
            ),
          ),
          TypingIndicatorWidget(isTyping: _isTyping, typingUser: _typingUser),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _onTextChanged,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
