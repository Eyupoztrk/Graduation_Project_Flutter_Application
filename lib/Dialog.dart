import 'dart:io';

class Dialog{
  String _botResponse = '';

  String getResponse(String message) {
    if (message.toLowerCase().contains('hello')) {
      return 'Hi, how can I help you?';
    } else if (message.toLowerCase().contains('normal') || message.toLowerCase().contains('street')) {
      return 'Street model opens';
    }
    else
      return 'not understood';
  }

  void _setBotResponse(String response) {

    _botResponse = response;

  }
}