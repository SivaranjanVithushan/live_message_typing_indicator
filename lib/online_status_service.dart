// online_status_service.dart
import 'package:ably_flutter/ably_flutter.dart' as ably;

class OnlineStatusService {
  late final ably.Realtime realtime;
  late final ably.RealtimeChannel channel;
  final String userId;

  OnlineStatusService(this.userId) {
    realtime = ably.Realtime(
      options: ably.ClientOptions(
        key: "0LNvUg.F_z08A:DQcZ3V8nbmkD9U7fmv-TvY6gzuVAurJFi4TnqMK6hAg",
        clientId: userId,
      ),
    );

    channel = realtime.channels.get("online-status");

    // Listen for connection state changes
    realtime.connection.on().listen((ably.ConnectionStateChange stateChange) {
      print('Connection state changed: ${stateChange.current}');
      if (stateChange.reason != null) {
        print('Connection error: ${stateChange.reason}');
      }
    });

    // Set the user as online when the connection is established
    realtime.connection.on(ably.ConnectionEvent.connected).listen((_) {
      setOnlineStatus(true);
    });

    // Set the user as offline when the connection is closed
    realtime.connection.on(ably.ConnectionEvent.closed).listen((_) {
      setOnlineStatus(false);
    });
  }

  void setOnlineStatus(bool isOnline) async {
    try {
      await channel.publish(name: 'online-status', data: {
        'userId': userId,
        'isOnline': isOnline,
      });
    } catch (e) {
      print('Failed to set online status: $e');
    }
  }

  void listenForOnlineStatusChanges(
      void Function(String userId, bool isOnline) onStatusChange) {
    channel.subscribe(name: 'online-status').listen((ably.Message message) {
      try {
        final data = Map<String, dynamic>.from(message.data as Map);
        final userId = data['userId'];
        final isOnline = data['isOnline'];
        onStatusChange(userId, isOnline);
      } catch (e) {
        print('Failed to process online status change: $e');
      }
    });
  }
}
