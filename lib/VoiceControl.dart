import 'dart:io';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';

class VoiceControl{
  final stt.SpeechToText _speechToText = stt.SpeechToText();


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
    print(result.recognizedWords);
  }

  void stopListening() async {
    await _speechToText.stop();
  }



}