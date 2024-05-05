import 'dart:async';
import 'package:bitirme_projesi/VoiceControl.dart';
import 'package:bitirme_projesi/TextTranslate.dart';
import 'package:flutter/material.dart';
import 'package:bitirme_projesi/DialogApps.dart';
import 'Application2.dart';
import 'text_to_speech.dart';
import 'Application.dart';
import 'package:camera/camera.dart';


late List<CameraDescription> cameras;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MaterialApp(home: MyApp()));

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {


  final TextTranslate textTranslate = TextTranslate();
  final VoiceControl voiceControl = VoiceControl();
  text_to_speech textToSpeech = text_to_speech();
 // final DialogApps dialogApps =DialogApps();


  Future<void> SetSpeakText()
  async {
    String speakText = "Welcome, just touch the screen once to give a voice command.";
    String TranslatedText =  await textTranslate.translate(speakText) ;
    textToSpeech.speakText(TranslatedText);
  }
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    SetSpeakText();
    voiceControl.initSpeech();
  }

  void openPage()
  {
    if(voiceControl.isAutomaticModel)
      {
        voiceControl.isAutomaticModel = false;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommandPage(),),  );
      }
    else
      {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommandPage2(),),  );
      }


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

                  openPage();
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommandPage(),
                    ),
                  );
                  // serverpost.sendToServer("merhaba");*/
                },


                onPressed: () {

                  voiceControl.startListening();
                  //textToSpeech.speakText("text");
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommandPage2(),),  );*/

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
