import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:devicelocale/devicelocale.dart';
import 'package:deepl_dart/deepl_dart.dart';



class TextTranslate{

  static const _apiKey = '90bcd743-2b29-4608-bc89-6482c4167c73:fx';
  String translatedTextt = '';


  Future<String> translate(String text) async {
    String apiKey = '90bcd743-2b29-4608-bc89-6482c4167c73:fx';
    //final targetLanguage = await Devicelocale.currentLocale;
    var targetLanguage = ui.window.locale.languageCode;
    //final targetLanguage = await Devicelocale.currentLocale;
    print(targetLanguage);
    //final targetLanguage = ui.window.locale.languageCode;

   // String targetLanguage = 'tr';
    // Construct Translator
    Translator translator = Translator(authKey: apiKey);

    // Translate single text
    // Get translated text from the first translation in the list
    // Get translated text from the first translation in the list
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
    //final targetLanguage = await Devicelocale.currentLocale;
   // final targetLanguage = ui.window.locale.languageCode;
    //final targetLanguage = ui.window.locale.languageCode;

    // String targetLanguage = 'tr';
    // Construct Translator
    Translator translator = Translator(authKey: apiKey);

    // Translate single text
    // Get translated text from the first translation in the list
    // Get translated text from the first translation in the list
    TextResult result = await translator.translateTextSingular(text, "en-US"!);
    String translatedText = result.text;

    // Return translated text
    translatedTextt = translatedText;
    return translatedText;
  }



}