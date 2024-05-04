import 'dart:io';
import 'dart:math';

import 'TextTranslate.dart';

class Dialog{
  final TextTranslate textTranslate = TextTranslate();
  String _botResponse = '';

  List<String> randomResponses = [
    'Hello!',
    'Hi there!',
    'Hey, how can I assist you?',
    'Hello, how can I help you today?',
    'Hi, what can I do for you?',
  ];

  String generateRandomResponse() {
    int randomIndex = Random().nextInt(randomResponses.length);
    return randomResponses[randomIndex];
  }

  String getResponse(String message) {

   // String message = "";
  /*  SetSpeakText(text).then((String result) {

      message = result;
    });*/
    if (message.toLowerCase().contains('hello') || message.toLowerCase().contains('hi') || message.toLowerCase().contains('hey')) {
      return  generateRandomResponse();
    } else if (message.toLowerCase().contains('normal') || message.toLowerCase().contains('street')) {
      return 'Street model opens';
    }
    else if (message.toLowerCase().contains('how are you') || message.toLowerCase().contains("how's it going")) {
      return 'Thanks, what about you';
    }
    else
      return 'not understood';
  }

  void setBotResponse(String response) {

    _botResponse = response;

  }

  Future<String> SetSpeakText(String Text)
  async {
    String TranslatedText =  await textTranslate.translate_en(Text) ;
    return TranslatedText;
  }
}