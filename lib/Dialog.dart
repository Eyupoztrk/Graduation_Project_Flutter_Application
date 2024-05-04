import 'dart:io';

class Dialog{
  String _botResponse = '';

  String _getResponse(String message) {
    if (message.toLowerCase().contains('Hello')) {
      return 'Hi, how can I help you?';
    } else if (message.toLowerCase().contains('Street')) {
      return 'Street model opens';
    }
    else
      return 'not understood';
  }

  void _setBotResponse(String response) {

    _botResponse = response;

  }
}