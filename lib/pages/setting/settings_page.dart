import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:http/http.dart' as http;

class GeminiChatBot extends StatefulWidget {
  const GeminiChatBot({Key? key}) : super(key: key);

  @override
  State<GeminiChatBot> createState() => _GeminiChatBotState();
}

class _GeminiChatBotState extends State<GeminiChatBot> {
  ChatUser myself = ChatUser(id: '1', firstName: 'Ruchika');
  ChatUser bot = ChatUser(id: '2', firstName: 'Health It');

  List<ChatMessage> allMessages = [];

  final header = {
    'Content-Type': 'application/json',
  };

  getData(ChatMessage m) async {
    allMessages.insert(0, m);
    setState(() {});

    var data = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };

    await http
        .post(
        Uri.parse(
            'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyCZXuuZgQdhyM-EyYQF_rqCr5ZDovvvOOo'),
        headers: header,
        body: jsonEncode(data))
        .then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        print(result['candidates'][0]['content']['parts'][0]['text']);
        ChatMessage m1 = ChatMessage(
            user: bot,
            createdAt: DateTime.now(),
            text: result['candidates'][0]['content']['parts'][0]['text']);

        allMessages.insert(0, m1);
        setState(() {

        });
      } else {
        print('error');
      }
    }).catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: DashChat(
          currentUser: myself,
          onSend: (ChatMessage m) {
            getData(m);
          },
          messages: allMessages,
        ),
      ),
    );
  }
}