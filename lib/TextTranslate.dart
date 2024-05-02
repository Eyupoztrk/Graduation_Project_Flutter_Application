import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:devicelocale/devicelocale.dart';
import 'package:deepl_dart/deepl_dart.dart';



class TextTranslate{

  static const _apiKey = '90bcd743-2b29-4608-bc89-6482c4167c73:fx';
   Future<String> translateTextttttttttt(String text) async {
    //final targetLanguage = await Devicelocale.currentLocale;
    final targetLanguage = ui.window.locale.languageCode;
    print("text target Languange: ");
    print(targetLanguage);

    final baseUrl = 'https://api.deepl.com/v2/translate';
    final endpoint = '$baseUrl?q=${Uri.encodeComponent(text)}&target=$targetLanguage&key=$_apiKey';

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final translatedText = data['data']['translations'][0]['translatedText'];
      return translatedText;
    } else {
      throw Exception('Failed to translate text');
    }

  }
  String translatedTextt = '';

  void main() async {
    // API Key
    String apiKey = '90bcd743-2b29-4608-bc89-6482c4167c73:fx';

    // Example Usage
    String translatedText = await translate('Hello World');
    print(translatedText);
  }

  Future<String> translate(String text) async {
    String apiKey = '90bcd743-2b29-4608-bc89-6482c4167c73:fx';
    //final targetLanguage = await Devicelocale.currentLocale;
    final targetLanguage = ui.window.locale.languageCode;
    print("text target Languange: ");
    print(targetLanguage);
    //final targetLanguage = ui.window.locale.languageCode;

   // String targetLanguage = 'tr';
    // Construct Translator
    Translator translator = Translator(authKey: apiKey);

    // Translate single text
    // Get translated text from the first translation in the list
    // Get translated text from the first translation in the list
    TextResult result = await translator.translateTextSingular(text, "en-US"!);
    print("SSSSSSSSSSSSSSSSSSSSSSSSS");
    print(result.text);

    String translatedText = result.text;

    // Return translated text
    translatedTextt = translatedText;
    return translatedText;
  }



}