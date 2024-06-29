// typing_indicator_widget.dart
import 'package:flutter/material.dart';

class TypingIndicatorWidget extends StatelessWidget {
  final bool isTyping;
  final String typingUser;

  const TypingIndicatorWidget(
      {super.key, required this.isTyping, required this.typingUser});

  @override
  Widget build(BuildContext context) {
    return isTyping
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$typingUser is typing...',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          )
        : const SizedBox.shrink();
  }
}
