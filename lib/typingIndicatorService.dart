// typing_indicator_service.dart
import 'package:ably_flutter/ably_flutter.dart' as ably;

class TypingIndicatorService {
  late final ably.Realtime realtime;
  late final ably.RealtimeChannel channel;

  TypingIndicatorService(String clientId) {
    realtime = ably.Realtime(
      options: ably.ClientOptions(
        key: "0LNvUg.F_z08A:DQcZ3V8nbmkD9U7fmv-TvY6gzuVAurJFi4TnqMK6hAg",
        clientId: clientId,
      ),
    );

    realtime.connection.on().listen((ably.ConnectionStateChange stateChange) {
      print('Connection state changed: ${stateChange.current}');
      if (stateChange.reason != null) {
        print('Connection error: ${stateChange.reason}');
      }
    });
    channel = realtime.channels.get('typing');
  }

  void sendTypingEvent(String userId) async {
    try {
      print("Sending typing event");
      await channel.publish(name: 'typing', data: {'userId': userId});
    } catch (e) {
      print('Failed to send typing event: $e');
    }
  }

  void listenForTypingEvents(void Function(String userId) onTyping) {
    channel.subscribe(name: 'typing').listen((ably.Message message) {
      try {
        final data = Map<String, dynamic>.from(message.data as Map);
        final userId = data['userId'];
        onTyping(userId);
      } catch (e) {
        print('Failed to process typing event: $e');
      }
    });
  }
}
