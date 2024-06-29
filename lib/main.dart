// // main.dart
// import 'package:flutter/material.dart';
// import 'chat_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Typing Indicator Test',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const TypingIndicatorTest(),
//     );
//   }
// }

// class TypingIndicatorTest extends StatelessWidget {
//   const TypingIndicatorTest({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Typing Indicator Test'),
//       ),
//       body: const Column(
//         children: [
//           Expanded(
//             child: ChatScreen(
//               userId: 'oxopiVwg',
//               otherUserId: 'kC17Vge2',
//             ),
//           ),
//           Expanded(
//             child: ChatScreen(
//               userId: 'kC17Vge2',
//               otherUserId: 'oxopiVwg',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// main.dart
import 'package:flutter/material.dart';
import 'chat_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat List with Online Status',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatListTest(),
    );
  }
}

class ChatListTest extends StatelessWidget {
  final String apiKey = 'your_ably_api_key';
  final List<String> chatUserIds = ['user1', 'user2', 'user3'];

  @override
  Widget build(BuildContext context) {
    return ChatListScreen(
      userId: 'currentUserId',
      chatUserIds: chatUserIds,
    );
  }
}
