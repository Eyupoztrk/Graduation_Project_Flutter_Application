import 'dart:io';
import 'package:bitirme_projesi/DialogApps.dart';
import 'package:bitirme_projesi/TextTranslate.dart';
import 'package:bitirme_projesi/text_to_speech.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';
import 'dart:ui' as ui;

class VoiceControl{
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final DialogApps dialog = DialogApps();
  final text_to_speech textToSpeech = text_to_speech();
  final TextTranslate textTranslate = TextTranslate();
  bool isAutomaticModel = false;
  int modelNumber =0;


  void initSpeech() async {
    bool speechEnabled = await _speechToText.initialize();

    if (!speechEnabled) {
      print("The user has denied the use of speech recognition.");
    }
  }

  void startListening() async {
    final targetLanguage = ui.window.locale.languageCode;
    await _speechToText.listen(
      onResult: onSpeechResult,
      localeId: targetLanguage,
    );
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      SetEgText(result.recognizedWords);
    }
  }


  Future<void> SetEgText(String Text)
  async {
    String TranslatedText =  await textTranslate.translate_en(Text) ;
    SetSpeakText(TranslatedText);
  }

  Future<void> SetSpeakText(String Text)
  async {

    String returnedMessage = dialog.getResponse(Text);
    print(returnedMessage);
    String TranslatedText =  await textTranslate.translate(returnedMessage) ;
    isAutomaticModel = dialog.isAutomaticModel;
    modelNumber = dialog.modelNumber;
    textToSpeech.speakText(TranslatedText);
  }



  void stopListening() async {
    await _speechToText.stop();
  }



}