import 'package:flutter/material.dart';
import '../models/quiz.dart';
import '../services/quiz_service.dart';
import '../widgets/appbar_widget.dart';

class HomeScreen extends StatefulWidget {
  final QuizService _quizService = QuizService();
  List<Quiz> _quizzes = <Quiz>[];
  int _activeQuestionId = 0;

  HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _question = null;
  int _score = 0;
  bool _loading = false;
  bool _gameOver = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
            future: widget._quizService.getQuizzes(),
            builder: (context, snapshot) {
              if (_gameOver) {
                return AlertDialog(
                  title: const Text(
                    'Game Over',
                    style: TextStyle(color: Colors.red),
                  ),
                  content: Text(
                    'Score: $_score',
                    style: TextStyle(color: Colors.purple),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        widget._activeQuestionId = 0;
                        setState(() {
                          _gameOver = false;
                          _score = 0;
                        });
                      },
                      child: const Text(
                        'Recommencer',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                  ],
                );
              }

              if (snapshot.hasData || _loading) {
                List<Quiz> data = snapshot.data as List<Quiz>;
                widget._quizzes = data;
                _question = widget._quizzes[widget._activeQuestionId].question!;
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Thème : La Grêce antique",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        (widget._activeQuestionId + 1).toString() + "/10",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      Text(_question ?? 'Question introuvable'),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green)),
                            onPressed: () {
                              setActiveAnswer();
                            },
                            child: const Text(
                              'Vrai',
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            child: const Text(
                              'Faux',
                            ),
                            onPressed: () {
                              setActiveAnswer(false);
                            },
                          )
                        ],
                      ),
                    ]);
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  void setActiveAnswer([bool value = true]) {
    _loading = true;
    if (widget._activeQuestionId.toInt() >= widget._quizzes.length - 1) {
      _loading = false;
      setState(() {
        _gameOver = true;
      });
      return;
    }

    if (widget._quizzes[widget._activeQuestionId].answer.toString() ==
        value.toString()) {
      setState(() {
        _score = _score + 1;
      });
    }

    widget._activeQuestionId++;
    setState(() {
      _question = widget._quizzes[widget._activeQuestionId].question!;
    });
    _loading = false;
  }
}
