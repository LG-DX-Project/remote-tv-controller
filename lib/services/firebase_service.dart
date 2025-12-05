import 'package:cloud_firestore/cloud_firestore.dart';

/// Firebase를 통한 리모컨 명령 전송 서비스
class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // TV 화면과 앱이 공유할 컬렉션 경로
  static const String _commandCollection = 'remote_commands';
  static const String _commandDocument = 'current_command';

  /// 리모컨 명령을 Firebase에 전송
  /// 
  /// [command] - 명령 타입 (예: 'up', 'down', 'left', 'right', 'click', 'channel_up', 'channel_down', 'power', 등)
  /// [value] - 추가 값 (예: 채널 번호)
  static Future<void> sendCommand({
    required String command,
    dynamic value,
  }) async {
    try {
      await _firestore
          .collection(_commandCollection)
          .doc(_commandDocument)
          .set({
        'command': command,
        'value': value,
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Firebase 명령 전송 오류: $e');
      rethrow;
    }
  }

  /// Firebase에서 명령을 실시간으로 수신하는 스트림
  /// 웹(TV 화면)에서 사용
  static Stream<Map<String, dynamic>> getCommandStream() {
    return _firestore
        .collection(_commandCollection)
        .doc(_commandDocument)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return snapshot.data()!;
      }
      return {};
    });
  }

  /// 특정 명령 타입만 필터링하여 수신하는 스트림
  static Stream<Map<String, dynamic>> getCommandStreamByType(String commandType) {
    return getCommandStream().where((data) => data['command'] == commandType);
  }
}

