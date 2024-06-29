// chat_list_screen.dart
import 'package:ably_typing_indicator/bloc/online_status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  final String userId;
  final List<String> chatUserIds;

  ChatListScreen({
    required this.userId,
    required this.chatUserIds,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnlineStatusCubit(userId),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chat List'),
        ),
        body: BlocBuilder<OnlineStatusCubit, Map<String, bool>>(
          builder: (context, onlineStatus) {
            return ListView.builder(
              itemCount: chatUserIds.length,
              itemBuilder: (context, index) {
                final chatUserId = chatUserIds[index];
                final isOnline = onlineStatus[chatUserId] ?? false;
                return ListTile(
                  title: Text(chatUserId),
                  trailing: Icon(
                    Icons.circle,
                    color: isOnline ? Colors.green : Colors.red,
                  ),
                  onTap: () {
                    // Navigate to chat screen with the selected user
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        userId: userId,
                        otherUserId: chatUserId,
                      ),
                    ));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
