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

class CommandPage extends StatefulWidget {
  const CommandPage({super.key});

  @override
  State<CommandPage> createState() => _commandPageState();
}

class _commandPageState extends State<CommandPage> {
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
    String speakText = "This is the street asistance section.";
    String TranslatedText =  await textTranslate.translate(speakText) ;
    _speech.speakText(TranslatedText);
  }

  @override
  void initState()  {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    _server.connectServer();
    SetSpeakText();
  // _speech.speakText("This is the street asistance section.");

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
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        // Resimleri çekmeye yarar
        _takePicture();
        //resultMessage = _server.messageFromServer;
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
    _server.sendToServer(base64code);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 162, 175, 221),
          title: const Text(
            "General Model",
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: Column(children: [
            Text("Photo taking is automatic",textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
            ]
          ),
        )
      ),
    );
  }
}
