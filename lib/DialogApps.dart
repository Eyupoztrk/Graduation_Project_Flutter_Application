import 'dart:io';
import 'dart:math';

import 'TextTranslate.dart';

class DialogApps{
  final TextTranslate textTranslate = TextTranslate();
  bool isAutomaticModel = false;

  List<String> entryList = [
    'Hello!',
    'Hi there!',
    'Hey, how can I assist you?',
    'Hello, how can I help you today?',
    'Hi, what can I do for you?',
  ];

  List<String> stateList = [
    "I'm doing well, thank you! How about yourself?",
    "I'm good, thank you! And you?",
    "I'm great, thanks for asking! How can I assist you?",
    "I'm doing fine, thanks! How can I help you today?",
    "I'm doing well, thank you for asking! What can I do for you?"
  ];

  String generateRandomResponse(List<String> list) {
    int randomIndex = Random().nextInt(list.length);
    return list[randomIndex];
  }

  String getResponse(String message) {

    if (message.toLowerCase().contains('hello') || message.toLowerCase().contains('hi') || message.toLowerCase().contains('hey')) {
      return  generateRandomResponse(entryList);
    }
    else if (message.toLowerCase().contains("how are you") ||
        message.toLowerCase().contains("how's it going") ||
        message.toLowerCase().contains("doing") ||
        message.toLowerCase().contains("today") ||
        message.toLowerCase().contains("feeling") ||
        message.toLowerCase().contains("going")) {
      return generateRandomResponse(stateList);
    }
    else if (message.toLowerCase().contains('normal') || message.toLowerCase().contains('street') || message.toLowerCase().contains('automatic') ) {
      isAutomaticModel = true;
      return 'Street model selected, press and hold to enter';
    }

    else if (message.toLowerCase().contains('market') || message.toLowerCase().contains('shopping') || message.toLowerCase().contains('shop') ) {
      isAutomaticModel = false;
      return 'Shopping model selected, press and hold to enter';
    }
    else
      return 'not understood';
  }


  Future<String> SetSpeakText(String Text)
  async {
    String TranslatedText =  await textTranslate.translate_en(Text) ;
    return TranslatedText;
  }
}