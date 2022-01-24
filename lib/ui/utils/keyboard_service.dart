import 'package:flutter/services.dart';

class KeyboardService {
  static Future<void> hide() async {
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
