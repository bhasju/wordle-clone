import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'dart:convert';
import "package:wordle/wordle_logic.dart";
import 'custom_keyboard/custom_keyboard.dart';


void main() {
  runApp(const MaterialApp(
    home: MainPage(),
  ));
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("wordle"),
        backgroundColor: Colors.blueGrey[800],
      ),
      backgroundColor: Colors.blueGrey[900],
      resizeToAvoidBottomInset: true,
      body: const SingleChildScrollView(child: WordleLayout()),
    );
  }
}

class SingleLetterBox extends StatelessWidget {
  const SingleLetterBox({
    Key? key,
    this.colorstate = 0,
    this.letter = " ",
  }) : super(key: key);

  final int colorstate;
  final String letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      child: Text(
        letter,
        style: TextStyle(
          fontSize: 30,
          color: Colors.indigo[200],
        ),
      ),
      color: (colorstate == 1)
          ? Colors.yellow[400]
          : (colorstate == 2)
              ? Colors.green[600]
              : Colors.grey[600],
    );
  }
}

class SingleWord extends StatelessWidget {
  const SingleWord(
      {Key? key,
      this.isDefined = false,
      this.colorStateList = const [0, 0, 0, 0, 0],
      this.word = "blank"})
      : super(key: key);
  final bool isDefined;
  final String word;
  final List<int> colorStateList;

  _generateLetterList() {
    List<String> charList = ["  ", "  ", "  ", "  ", "  ", "  "];
    if (isDefined) {
      charList = word.split('');
    }
    List<Widget> widgetList = [];
    for (int i = 0; i < 5; i++) {
      widgetList.add(SingleLetterBox(
        colorstate: colorStateList[i],
        letter: charList[i],
      ));
    }
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _generateLetterList(),
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}

class WordleLayout extends StatefulWidget {
  const WordleLayout({Key? key}) : super(key: key);

  @override
  _WordleLayoutState createState() => _WordleLayoutState();
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class _WordleLayoutState extends State<WordleLayout> {
  WordleLogic logic = WordleLogic();
  int guessIndex = -1;
  List<SingleWord> wordStateList =
      List<SingleWord>.generate(6, (index) => const SingleWord());

  void _updateWord(String value) {
    setState(() {
      if (logic.validGuess == true) {
        guessIndex++;
        debugPrint(logic.wordle);
        wordStateList[guessIndex] = SingleWord(
          word: value,
          isDefined: true,
          colorStateList: logic.colorStateList,
        );
      } else {
        return;
      }
    });
  }

  void _resetState() {
    setState(() {
      logic = WordleLogic();
      guessIndex = -1;
      wordStateList =
          List<SingleWord>.generate(6, (index) => const SingleWord());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < 6; i++) wordStateList[i],
        TextField(
          onSubmitted: (value) {
            debugPrint(value);
            logic.wordVerifier(value);
            _updateWord(value);
            if (!logic.validGuess) {
              final snackBar = SnackBar(content: Text(logic.whyNotValid));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (value.toLowerCase() == logic.wordle) {
              final resetSnackBar = SnackBar(
                content: const Text("Yay!! You win!"),
                action: SnackBarAction(
                  label: "play again!",
                  onPressed: () {
                    _resetState();
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(resetSnackBar);
            }

            if (value.toLowerCase() != logic.wordle && guessIndex == 5) {
              final FailureSnackBar = SnackBar(
                content: Text("Aww! Next time! the word was " + logic.wordle),
                action: SnackBarAction(
                  label: "play again!",
                  onPressed: () {
                    _resetState();
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(FailureSnackBar);
            }
          },
          inputFormatters: [UpperCaseTextFormatter()],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        CustomKeyBoard()
      ],
    );
  }
}
