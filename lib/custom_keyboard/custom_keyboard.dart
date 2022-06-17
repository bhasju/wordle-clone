import 'package:flutter/material.dart';
import 'operation_key.dart';
import 'single_key.dart';

class CustomKeyBoard extends StatelessWidget {
  CustomKeyBoard({
    Key? key,
    this.onBackspace,
    this.onEnter,
    this.onTextInput,
  }) : super(key: key);
  void Function(String)? onTextInput;
  Function? onEnter, onBackspace;
  List<String> alphabetList = [
    "q",
    "u",
    "e",
    "r",
    "t",
    "y",
    "u",
    "i",
    "o",
    "p",
    "a",
    "s",
    "d",
    "f",
    "g",
    "h",
    "j",
    "k",
    "l",
    "z",
    "x",
    "c",
    "v",
    "b",
    "n",
    "m"
  ];

  late Map<String, Widget> charMap = Map.fromIterable(
    alphabetList,
    key: (element) => element,
    value: (element) => TextKey(
      text: element,
      onTextInput: onTextInput,
    ),
  );
  List<List<String>> charPositions = [
    ["q", "u", "e", "r", "t", "y", "u", "i", "o", "p"],
    ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
    ["z", "x", "c", "v", "b", "n", "m"]
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 160,
        color: Colors.blue,
        child: Column(
            // <-- Column
            children: [
              Expanded(
                child: Row(
                  children: List.generate(
                      10,
                      (index) =>
                          charMap[charPositions[1][index]] ??= Text("?")),
                ),
              ),
              Expanded(
                child: Row(
                  children: List.generate(
                      10,
                      (index) =>
                          charMap[charPositions[2][index]] ??= Text("?")),
                ),
              ),
              Expanded(
                child: Row(
                  children: List.generate(
                      10,
                      (index) =>
                          charMap[charPositions[1][index]] ??= Text("?")),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    BackspaceKey(
                      onBackSpace: onBackspace,
                    ),
                    EnterKey(
                      onEnter: onEnter,
                    )
                  ],
                ),
              ),
            ]));
  }
}
