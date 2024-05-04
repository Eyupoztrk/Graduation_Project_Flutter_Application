import 'dart:io';
import 'package:bitirme_projesi/Dialog.dart';
import 'package:bitirme_projesi/text_to_speech.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';

class VoiceControl{
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final Dialog dialog = Dialog();
  final text_to_speech textToSpeech = text_to_speech();



  void initSpeech() async {
    bool speechEnabled = await _speechToText.initialize();

    if (!speechEnabled) {
      print("The user has denied the use of speech recognition.");
    }
  }

  void startListening() async {
    await _speechToText.listen(
      onResult: onSpeechResult,
    );
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      String returnetMessage = dialog.getResponse(result.recognizedWords);
      textToSpeech.speakText(returnetMessage);
      print(result.recognizedWords);
    }
  }

  void stopListening() async {
    await _speechToText.stop();
  }



}