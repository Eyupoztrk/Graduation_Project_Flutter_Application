import 'package:flutter_tts/flutter_tts.dart';
import 'package:devicelocale/devicelocale.dart';
import 'dart:ui' as ui;


class text_to_speech {
  FlutterTts flutterTts = FlutterTts();
  bool isSpeakComplete = false;

  Future<void> configureTts() async {
   // final targetLanguage = await Devicelocale.currentLocale;
    final targetLanguage = ui.window.locale.languageCode;
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(2.0);
    await flutterTts.setVolume(1.0);
  }

  void speakText(String text) async {
    final targetLanguage = await Devicelocale.currentLocale;
   // final targetLanguage = ui.window.locale.languageCode;
    //await flutterTts.setLanguage(targetLanguage!);
   /* await flutterTts.setLanguage("tr-TR");
    await flutterTts.setSpeechRate(2.0);
    await flutterTts.setVolume(1.0);*/
    await flutterTts.speak(text);
    flutterTts.setCompletionHandler(() {
      // Konuşma tamamlandığında yapılacak işlemleri burada tanımlayabilirsiniz.
      final targetLanguage = ui.window.locale.languageCode;

      print('Konuşma tamamlandı.');
      isSpeakComplete = true;
    });
  }

  void stopSpeaking() async {
    await flutterTts.stop();
  }
}
