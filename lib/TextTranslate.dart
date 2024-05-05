import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:deepl_dart/deepl_dart.dart';



class TextTranslate{

  static const _apiKey = '90bcd743-2b29-4608-bc89-6482c4167c73:fx';
  String translatedTextt = '';


  Future<String> translate(String text) async {
    String apiKey = '90bcd743-2b29-4608-bc89-6482c4167c73:fx';
    var targetLanguage = ui.window.locale.languageCode;
    print(targetLanguage);
    Translator translator = Translator(authKey: apiKey);


    if(targetLanguage == "en")
      {
        targetLanguage = "en-US";
      }
    TextResult result = await translator.translateTextSingular(text, targetLanguage!);
    String translatedText = result.text;

    // Return translated text
    translatedTextt = translatedText;
    return translatedText;
  }

  Future<String> translate_en(String text) async {
    String apiKey = '90bcd743-2b29-4608-bc89-6482c4167c73:fx';
    Translator translator = Translator(authKey: apiKey);
    TextResult result = await translator.translateTextSingular(text, "en-US"!);
    String translatedText = result.text;

    // Return translated text
    translatedTextt = translatedText;
    return translatedText;
  }



}