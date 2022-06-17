import 'dart:math';
import 'package:wordle/word_list.dart' as constants;

class WordleLogic {
  final String wordle =
      constants.words[Random().nextInt(constants.words.length)];
  bool validGuess = true;
  String whyNotValid = "  ";
  List<int> colorStateList = [0, 0, 0, 0, 0];
  void wordVerifier(String guess) {
    validGuess = true;
    guess = guess.toLowerCase();
    if (guess.length != 5) {
      validGuess = false;
      whyNotValid = "guess must have 5 letters";
    } else if (guess.split('').contains(" ")) {
      validGuess = false;
      whyNotValid = "guess should not have space";
    } else if (!constants.validGuesses.contains(guess) &&
        !constants.words.contains(guess)) {
      validGuess = false;
      whyNotValid = "guess must be a real word";
    }
    List<String> wordleLetters = wordle.split("");
    List<String> guessLetters = guess.split("");
    if (validGuess != false) {
      for (int i = 0; i < 5; i++) {
        if (wordleLetters.contains(guessLetters[i]) &&
            wordleLetters[i] == guessLetters[i]) {
          colorStateList[i] = 2;
        } else if (wordleLetters.contains(guessLetters[i])) {
          colorStateList[i] = 1;
        } else {
          colorStateList[i] = 0;
        }
      }
    }
  }
}
