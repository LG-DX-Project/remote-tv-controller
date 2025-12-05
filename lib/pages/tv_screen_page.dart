import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

/// TV 화면 페이지 - Firebase에서 리모컨 명령을 실시간으로 수신하여 처리
class TVScreenPage extends StatefulWidget {
  const TVScreenPage({super.key});

  @override
  State<TVScreenPage> createState() => _TVScreenPageState();
}

class _TVScreenPageState extends State<TVScreenPage> {
  String _lastCommand = '대기 중...';
  String _lastValue = '';
  DateTime? _lastCommandTime;

  @override
  void initState() {
    super.initState();
    _listenToCommands();
  }

  /// Firebase에서 명령을 실시간으로 수신
  void _listenToCommands() {
    FirebaseService.getCommandStream().listen((data) {
      if (data.isNotEmpty && data['command'] != null) {
        setState(() {
          _lastCommand = data['command'] as String;
          _lastValue = data['value']?.toString() ?? '';
          _lastCommandTime = DateTime.now();
        });

        // 명령 처리
        _handleCommand(data['command'] as String, data['value']);
      }
    });
  }

  /// 수신한 명령을 처리
  void _handleCommand(String command, dynamic value) {
    switch (command) {
      case 'up':
        _handleUp();
        break;
      case 'down':
        _handleDown();
        break;
      case 'left':
        _handleLeft();
        break;
      case 'right':
        _handleRight();
        break;
      case 'click':
        _handleClick();
        break;
      case 'channel_up':
        _handleChannelUp(value);
        break;
      case 'channel_down':
        _handleChannelDown(value);
        break;
      case 'volume_up':
        _handleVolumeUp(value);
        break;
      case 'volume_down':
        _handleVolumeDown(value);
        break;
      case 'power':
        _handlePower();
        break;
      case 'menu':
        _handleMenu();
        break;
      case 'home':
        _handleHome();
        break;
      case 'back':
        _handleBack();
        break;
      case 'mute':
        _handleMute();
        break;
      default:
        print('알 수 없는 명령: $command');
    }
  }

  // 각 명령에 대한 핸들러 메서드들
  void _handleUp() {
    print('TV: 위로 이동');
    // 여기에 실제 TV 화면에서 위로 이동하는 로직 구현
  }

  void _handleDown() {
    print('TV: 아래로 이동');
    // 여기에 실제 TV 화면에서 아래로 이동하는 로직 구현
  }

  void _handleLeft() {
    print('TV: 왼쪽으로 이동');
    // 여기에 실제 TV 화면에서 왼쪽으로 이동하는 로직 구현
  }

  void _handleRight() {
    print('TV: 오른쪽으로 이동');
    // 여기에 실제 TV 화면에서 오른쪽으로 이동하는 로직 구현
  }

  void _handleClick() {
    print('TV: 클릭');
    // 여기에 실제 TV 화면에서 클릭하는 로직 구현
  }

  void _handleChannelUp(dynamic value) {
    print('TV: 채널 업 - 채널 번호: $value');
    // 여기에 실제 TV 화면에서 채널을 올리는 로직 구현
  }

  void _handleChannelDown(dynamic value) {
    print('TV: 채널 다운 - 채널 번호: $value');
    // 여기에 실제 TV 화면에서 채널을 내리는 로직 구현
  }

  void _handleVolumeUp(dynamic value) {
    print('TV: 음량 업 - 음량: $value');
    // 여기에 실제 TV 화면에서 음량을 올리는 로직 구현
  }

  void _handleVolumeDown(dynamic value) {
    print('TV: 음량 다운 - 음량: $value');
    // 여기에 실제 TV 화면에서 음량을 내리는 로직 구현
  }

  void _handlePower() {
    print('TV: 전원');
    // 여기에 실제 TV 화면에서 전원을 켜거나 끄는 로직 구현
  }

  void _handleMenu() {
    print('TV: 메뉴');
    // 여기에 실제 TV 화면에서 메뉴를 여는 로직 구현
  }

  void _handleHome() {
    print('TV: 홈');
    // 여기에 실제 TV 화면에서 홈으로 이동하는 로직 구현
  }

  void _handleBack() {
    print('TV: 뒤로가기');
    // 여기에 실제 TV 화면에서 뒤로가기 하는 로직 구현
  }

  void _handleMute() {
    print('TV: 음소거');
    // 여기에 실제 TV 화면에서 음소거를 토글하는 로직 구현
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'TV 화면',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    '마지막 명령: $_lastCommand',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  if (_lastValue.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      '값: $_lastValue',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ],
                  if (_lastCommandTime != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      '시간: ${_lastCommandTime!.toString().substring(11, 19)}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              '리모컨 앱에서 버튼을 누르면\n여기서 실시간으로 명령을 수신합니다',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

