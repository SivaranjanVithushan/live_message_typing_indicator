// // chat_screen.dart
// // ignore_for_file: library_private_types_in_public_api

// import 'package:ably_typing_indicator/online_status_service.dart';
// import 'package:ably_typing_indicator/typingIndicatorService.dart';
// import 'package:flutter/material.dart';

// import 'typing_indicator_widget.dart';

// class ChatScreen extends StatefulWidget {
//   final String userId;
//   final String otherUserId;

//   const ChatScreen(
//       {super.key, required this.userId, required this.otherUserId});

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   late TypingIndicatorService _typingIndicatorService;
//   late OnlineStatusService _onlineStatusService;
//   bool _isTyping = false;
//   String _typingUser = '';
//   // final Map<String, bool> _onlineUsers = {};
//   bool _isOtherUserOnline = false;

//   @override
//   void initState() {
//     super.initState();
//     _typingIndicatorService = TypingIndicatorService(widget.userId);
//     _onlineStatusService = OnlineStatusService(widget.userId);

//     _typingIndicatorService.listenForTypingEvents((userId) {
//       if (userId == widget.otherUserId) {
//         setState(() {
//           _isTyping = true;
//           _typingUser = userId;
//         });
//         Future.delayed(const Duration(seconds: 3), () {
//           setState(() {
//             _isTyping = false;
//           });
//         });
//       }
//     });

//     _onlineStatusService.listenForOnlineStatusChanges((userId, isOnline) {
//       if (userId == widget.otherUserId) {
//         setState(() {
//           _isOtherUserOnline = isOnline;
//         });
//       }
//     });
//   }

//   void _onTextChanged(String text) {
//     _typingIndicatorService.sendTypingEvent(widget.userId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat with ${widget.otherUserId}'),
//         actions: [
//           _isOtherUserOnline
//               ? Icon(Icons.circle, color: Colors.green)
//               : Icon(Icons.circle, color: Colors.red),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView(
//               children: [
//                 // Your chat messages will go here
//               ],
//             ),
//           ),
//           TypingIndicatorWidget(isTyping: _isTyping, typingUser: _typingUser),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: _onTextChanged,
//               decoration: const InputDecoration(
//                 hintText: 'Type a message...',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// chat_screen.dart
import 'package:ably_typing_indicator/bloc/online_status_cubit.dart';
import 'package:ably_typing_indicator/typingIndicatorService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'typing_indicator_widget.dart';

class ChatScreen extends StatelessWidget {
  final String userId;
  final String otherUserId;

  ChatScreen({
    required this.userId,
    required this.otherUserId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnlineStatusCubit(userId),
      child: _ChatScreenView(
        userId: userId,
        otherUserId: otherUserId,
      ),
    );
  }
}

class _ChatScreenView extends StatefulWidget {
  final String userId;
  final String otherUserId;

  _ChatScreenView({
    required this.userId,
    required this.otherUserId,
  });

  @override
  __ChatScreenViewState createState() => __ChatScreenViewState();
}

class __ChatScreenViewState extends State<_ChatScreenView> {
  late TypingIndicatorService _typingIndicatorService;
  bool _isOtherUserTyping = false;

  @override
  void initState() {
    super.initState();
    _typingIndicatorService = TypingIndicatorService(widget.userId);

    _typingIndicatorService.listenForTypingEvents((userId) {
      if (userId == widget.otherUserId) {
        setState(() {
          _isOtherUserTyping = true;
        });
        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            _isOtherUserTyping = false;
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
        actions: [
          BlocBuilder<OnlineStatusCubit, Map<String, bool>>(
            builder: (context, onlineStatus) {
              final isOnline = onlineStatus[widget.otherUserId] ?? false;
              return Icon(
                Icons.circle,
                color: isOnline ? Colors.green : Colors.red,
              );
            },
          ),
        ],
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
          TypingIndicatorWidget(
              isTyping: _isOtherUserTyping, typingUser: widget.otherUserId),
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
