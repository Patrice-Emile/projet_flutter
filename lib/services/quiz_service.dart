import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../models/quiz.dart';

class QuizService {
  Future getQuizzes() async {
    try {
      String data = await rootBundle.loadString('assets/data.json');
      List jsonResult = json.decode(data);
      int id = 0;
      return jsonResult.map((item) {
        id++;
        return Quiz(id, item['question'] as String, item['answer'] as bool);
      }).toList();
    } catch (exc) {
      inspect(exc);
    }
  }

  Future setUsername(String username) async {
    inspect('username');
    inspect(username);
  }
}
