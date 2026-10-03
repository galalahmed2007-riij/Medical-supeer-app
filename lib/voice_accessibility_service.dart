import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class VoiceAccessibilityService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();

  VoiceAccessibilityService() {
    _initTts();
  }

  void _initTts() async {
    await _tts.setLanguage("ar-EG"); // ضبط اللغة العربية باللهجة المصرية
    await _tts.setSpeechRate(0.45); // إبطاء الصوت ليكون واضحاً ومفهوماً
  }

  // قراءة النصوص بصوت واضح للمستخدم
  Future<void> speak(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }

  // تحويل صوت العميل إلى نص
  Future<void> listen(Function(String text) onResult) async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(
        localeId: "ar_EG",
        onResult: (val) => onResult(val.recognizedWords),
      );
    }
  }

  void stopListening() {
    _speech.stop();
  }
}
