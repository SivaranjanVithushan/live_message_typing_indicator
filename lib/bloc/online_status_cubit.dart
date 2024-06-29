// online_status_cubit.dart
import 'package:ably_typing_indicator/online_status_service.dart';
import 'package:bloc/bloc.dart';
import 'package:ably_flutter/ably_flutter.dart' as ably;

class OnlineStatusCubit extends Cubit<Map<String, bool>> {
  final OnlineStatusService _onlineStatusService;

  OnlineStatusCubit(String userId)
      : _onlineStatusService = OnlineStatusService(userId),
        super({}) {
    _onlineStatusService.listenForOnlineStatusChanges((userId, isOnline) {
      emit({...state, userId: isOnline});
    });
  }

  void setOnlineStatus(String userId, bool isOnline) {
    _onlineStatusService.setOnlineStatus(isOnline);
  }
}
