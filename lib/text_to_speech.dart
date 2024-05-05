import 'package:flutter_tts/flutter_tts.dart';
import 'package:devicelocale/devicelocale.dart';
import 'dart:ui' as ui;

import 'main.dart';


class text_to_speech {
  FlutterTts flutterTts = FlutterTts();
  //MyAppState mainn = new MyAppState();
  bool isSpeakComplete = false;

  Future<void> configureTts() async {
    final targetLanguage = ui.window.locale.languageCode;
    await flutterTts.setLanguage(targetLanguage);
    await flutterTts.setSpeechRate(2.0);
    await flutterTts.setVolume(1.0);
  }

  void speakText(String text) async {
    isSpeakComplete = false;
    final targetLanguage = ui.window.locale.languageCode;
    print(targetLanguage);
    await flutterTts.setLanguage(targetLanguage);
    await flutterTts.speak(text);

    flutterTts.setCompletionHandler(() {

      print('Konuşma tamamlandı.');
      //mainn.openPage();
      isSpeakComplete = true;
    });

  }

  bool complete()
  {

    return isSpeakComplete;
  }

  void stopSpeaking() async {
    await flutterTts.stop();
  }
}
