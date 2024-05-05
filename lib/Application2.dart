import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:bitirme_projesi/text_to_speech.dart';
import 'package:bitirme_projesi/TextTranslate.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'server.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:math';
import 'dart:developer';
import 'package:image/image.dart' as img;

class CommandPage2 extends StatefulWidget {
//  const CommandPage2({super.key});

  final int model; // Yeni değişken

  const CommandPage2({Key? key, required this.model}) : super(key: key); // Constructor güncellendi


  @override
  State<CommandPage2> createState() => _commandPageState();
}

class _commandPageState extends State<CommandPage2> {


  late CameraController controller;
  Uint8List byteData = Uint8List.fromList([65, 66, 67, 68, 69]);
  final Server _server = Server();
  final TextTranslate textTranslate = TextTranslate();
  final text_to_speech _speech = text_to_speech();
  Timer _timer = Timer.periodic(const Duration(seconds: 1), (timer) {});
  late XFile lastPicture;
  late Image lastImage;
  late String resultMessage ="Gelen Veriler Burada Görünecektir";


  Future<void> SetSpeakText()
  async {
    String speakText = "This is the object asistance section.";
    String TranslatedText =  await textTranslate.translate(speakText) ;
    _speech.speakText(TranslatedText);
  }

  late int _model;

  @override
  void initState() {
    super.initState();
    _model = widget.model;
    print(_model);
    controller = CameraController(cameras[0], ResolutionPreset.max);
    lastImage = Image.network("https://assets-us-01-tlsnext.kc-usercontent.com/ffacfe7d-10b6-0083-2632-604077fd4eca/c7a6925a-f88d-4e0f-92e8-9254f575209f/Senior-man-with-vision-loss-crossing-street_FB_iStock-1292075242_2021-05_1200x630.jpg");
    _server.connectServer();
    SetSpeakText();
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });
    _startTimer(); // sonradan aktif et
  }

  @override
  void dispose() {
    _timer.cancel();
    controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (!controller.value.isInitialized) {
      return;
    }

    try {
      XFile file = await controller.takePicture();


      byteData = await file.readAsBytes();
      compressList(byteData);

    } catch (e) {
      print("Fotoğraf çekerken hata oluştu: $e");
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        //_takePicture();
        resultMessage = _server.messageFromServer;
      });
    });
  }


  Future<void> compressList(Uint8List list) async {
    print(list.length);
    Uint8List compressedBytes = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 250,
      minWidth: 250,
      quality: 90,
    );
    String base64code = base64Encode(compressedBytes);
   sendDataToServer(base64code);
  }

  void sendDataToServer(String base64code)
  {
    if(_model == 4)
      {
        _server.sendToServer(base64code +'\r');
      }

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 162, 175, 221),
          title: const Text(
            "Aplication 2 page",
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: Center(child:
            SizedBox.expand(
              child:  TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black,width: 5),
                      borderRadius: BorderRadius.zero, // Kare yapmak için sıfır kenar yarıçapı kullanılır
                    ),
                  ),

                ),

                onPressed: () {
                  _takePicture();
                },
                child: const Text("TAKE PHOTO"),


              ),
            )

        ),)
    );
  }
}
