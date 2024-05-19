import 'dart:io';
import 'dart:math';

import 'TextTranslate.dart';

class DialogApps{
  final TextTranslate textTranslate = TextTranslate();
  bool isAutomaticModel = false;
  late int modelNumber;

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
      isAutomaticModel = false;
      modelNumber = 0;
      return  generateRandomResponse(entryList);

    }
    else if (message.toLowerCase().contains("how are you") ||
        message.toLowerCase().contains("how's it going") ||
        message.toLowerCase().contains("doing") ||
        message.toLowerCase().contains("today") ||
        message.toLowerCase().contains("feeling") ||
        message.toLowerCase().contains("going")) {

      isAutomaticModel = false;
      modelNumber = 0;
      return generateRandomResponse(stateList);
    }
    else if (message.toLowerCase().contains('normal') || message.toLowerCase().contains('street') || message.toLowerCase().contains('automatic') ) {
      isAutomaticModel = true;
      modelNumber = 1;
      return 'You have selected the Street Assistance model, hold to enter';
    }

    else if (message.toLowerCase().contains('object') ) {
      modelNumber = 2;
      isAutomaticModel = false;
      return 'You have selected the object model, hold to enter';
    }
    else if (message.toLowerCase().contains('color') ) {
      modelNumber = 3;
      isAutomaticModel = false;
      return 'You have selected the color model, hold to enter';
    }
    else if (message.toLowerCase().contains('text') ) {
      modelNumber = 4;
      isAutomaticModel = false;
      return 'You have selected the text model, hold to enter';
    }
    else if (message.toLowerCase().contains('money') ) {
      modelNumber = 5;
      isAutomaticModel = false;
      return 'You have selected the money model, hold to enter';
    }

    else if (message.toLowerCase().contains('fruit') ) {
      modelNumber = 6;
      isAutomaticModel = false;
      return 'You have selected the fruit model, hold to enter';
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