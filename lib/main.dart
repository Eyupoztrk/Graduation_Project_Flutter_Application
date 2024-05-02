import 'package:bitirme_projesi/server.dart';
import 'package:bitirme_projesi/TextTranslate.dart';
import 'package:flutter/material.dart';
import 'Application2.dart';
import 'text_to_speech.dart';
import 'Application.dart';
import 'package:camera/camera.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MaterialApp(home: MyApp()));
  
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final TextTranslate textTranslate = TextTranslate();
  text_to_speech t = text_to_speech();


  final _speechEnabled = false;
  String _lastWords = '';
  String answerCommand = "";
  bool isStarting = false;
  final Server _server = Server();


  Future<void> SetSpeakText()
  async {
    String speakText = "Hello, welcome to the application. Long press the screen to identify object. Single press for street assistance";
    String TranslatedText =  await textTranslate.translate(speakText) ;
    t.speakText(TranslatedText);
  }

  @override
  void initState() {
    super.initState();
    SetSpeakText();
    print("maine girdi");
    _initSpeech();


    _startListening();
  }

  void _initSpeech() async {
    bool speechEnabled = await _speechToText.initialize();

    if (!speechEnabled) {
      print("The user has denied the use of speech recognition.");
    }
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
    );
    setState(() {});
  }

  void CheckListening(String command) {
    if (command.toLowerCase() == "Start") {

      print("Uygulama başlatılıyor..");
      //openOtherPage();
      // başladıktan sonra yapılacak işlemler
    }

    _stopListening();
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      //_command(_lastWords);
      print(_lastWords);
      // t.speakText(answerCommand);
      //print(_lastWords);
    });
  }

  @override
  Widget build(BuildContext context) {
    //Size deviceSize = MediaQuery.of(context).size;

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 162, 175, 221),
            title: const Text(
              "HELPING BLIND PEOPLE",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: SizedBox.expand(
              child:  TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black,width: 5),
                      borderRadius: BorderRadius.zero, // Kare yapmak için sıfır kenar yarıçapı kullanılır
                    ),
                  ),
                ),


                onLongPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommandPage(),
                    ),
                  );
                  // serverpost.sendToServer("merhaba");
                },


                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommandPage2(),),  );

                },
                child: const Text(
                  "START",
                  style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),),
            )

          ),
        ),
      ),
    );
  }
}
