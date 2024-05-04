import 'dart:io';
import 'package:bitirme_projesi/text_to_speech.dart';
import 'package:bitirme_projesi/TextTranslate.dart';
import 'package:udp/udp.dart';

class Server {
  String ipAdrress = "";

  late Socket socket;
  late RawDatagramSocket socket2;
  late String messageFromServer = "";
  final text_to_speech _speech = text_to_speech();
  final TextTranslate textTranslate = TextTranslate();

  void connectServer() async {
    try {
      //socket = await Socket.connect("4.234.179.119", 12346);
      socket = await Socket.connect("192.168.1.2", 12346);
      listenServer();
    } catch (e) {
      print('Bağlantı hatası: $e');
    }
  }
  void sendToServer(String blob) {
    print('Sunucuya gönderildi: $blob' );
    socket.writeln(blob);
  }

  listenServer() async {
    // Sunucudan gelen veriyi dinle

    socket.listen(
          (List<int> data) async {
        String serverMessage = String.fromCharCodes(data);
        print('Sunucudan gelen veri: $serverMessage');
        String translatedTex = await textTranslate.translate(serverMessage);

        print(translatedTex);
        _speech.speakText(translatedTex);
      },
      onDone: () {
        socket.destroy();
      },
      onError: (error) async {
        print('Hatasss: $error');
        String translatedTex = await textTranslate.translate("The connection has been destroyed, please reopen the application");
        print(translatedTex);
        _speech.speakText(translatedTex);
      },
      cancelOnError: true,
    );
  }

  void disconnectServer() {
    if (socket != null) {
      socket.destroy(); // Socket'i kapat
      // Socket'i null olarak ayarla
    }
  }







    Future<void> connectServer2() async {
      try {
        socket2 = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
        print('Sunucuya bağlanıldı.');
        //listenServer();
      } catch (e) {
        print('Bağlantı hatası: $e');
      }
    }


    void sendToServer2(String blob) {
      List<int> data = blob.codeUnits;
      socket2.send(data, InternetAddress('192.168.1.3'), 12346);
      print('Sunucuya gönderildi: $blob');
    }

    Future<void> ListenServer() async {
      try {
        socket2 =
        await RawDatagramSocket.bind(InternetAddress('0.0.0.0'), 12346);
        print('Sunucu dinleniyor...');
        socket2.listen((RawSocketEvent e) {
          if (e == RawSocketEvent.read) {
            Datagram? datagram = socket2.receive();
            if (datagram != null) {
              String message = String.fromCharCodes(datagram.data);
              messageFromServer = message;
            //  _speech.speakText(messageFromServer);
              print('Sunucudan alındı: $message');
            }
          }
        });
      } catch (e) {
        print('Bağlantı hatası: $e');
      }
    }


  }

