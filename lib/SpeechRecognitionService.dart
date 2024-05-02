import 'package:speech_to_text/speech_to_text.dart' as stt;

String command2 = "";

class SpeechRecognitionService {
  late stt.SpeechToText _speech;

  SpeechRecognitionService() {
    _speech = stt.SpeechToText();
  }

  Future<bool> startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(
        onResult: (result) {
          print("sdsss");
          print('Heard: ${result.recognizedWords}');
          // setCommand(result.recognizedWords);
          command2 = result.recognizedWords;
        },
      );
    }
    return available;
  }

  void stopListening() {
    _speech.stop();
  }
}
