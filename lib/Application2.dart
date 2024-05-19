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
  String speakText = "";


  Future<void> SetSpeakText(String SpeakText)
  async {
    speakText = SpeakText;
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
    _server.connectServer();

    if(_model == 2)
      {
        SetSpeakText("This is the Object assistance section.");
      }
    else if(_model == 3)
      {
        SetSpeakText("This is the Color assistance section.");
      }

    else if(_model == 4)
      {
        SetSpeakText("This is the Text assistance section.");
      }

    else if(_model == 5)
      {
        SetSpeakText("This is the Money assistance section.");
      }
    else if(_model == 6)
      {
        SetSpeakText("This is the Fruit assistance section.");
      }



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
   /* Uint8List compressedBytes = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 320,
      minWidth: 240,
      quality: 100,
    );*/
    String base64code = base64Encode(list);
   sendDataToServer(base64code);
  }

  void sendDataToServer(String base64code)
  {
    if(_model == 1)
      {
        _server.sendToServer('\r' +'1'+base64code);
      }
    else if(_model == 2)
      {
        _server.sendToServer('\r' +'2'+ base64code);
      }
    else if(_model == 3)
      {
        _server.sendToServer('\r' +'3'+ base64code);
      }
    else if(_model == 4)
    {
      _server.sendToServer('\r' +'4'+ base64code);
    }
    else if(_model == 5)
    {
      _server.sendToServer('\r' +'5'+ base64code);
    }
    else if(_model == 6)
    {
      _server.sendToServer('\r' +'6'+ base64code);
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
