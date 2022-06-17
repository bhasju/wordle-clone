import 'package:flutter/material.dart';

class TextKey extends StatelessWidget {
  const TextKey({
    Key? key,
    this.text = " ",
    this.onTextInput,
    this.flex = 1,
    this.colorstate = 0,
  }) : super(key: key);

  final String text;
  final ValueSetter<String>? onTextInput;
  final int flex;
  final int colorstate;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: (colorstate == 1)
              ? Colors.yellow[400]
              : (colorstate == 2)
                  ? Colors.green[600]
                  : Colors.grey[600],
          child: InkWell(
            onTap: () {
              onTextInput?.call(text);
            },
            child: Container(
              child: Center(child: Text(text)),
            ),
          ),
        ),
      ),
    );
  }
}
