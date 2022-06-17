import 'package:flutter/material.dart';

class OperationKey extends StatelessWidget {
  const OperationKey(
      {Key? key,
      this.onOperation,
      this.flex = 1,
      this.icon = const Icon(Icons.check)})
      : super(key: key);
  final Icon icon;
  final Function? onOperation;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Colors.blue.shade300,
          child: InkWell(
            onTap: () {
              onOperation?.call();
            },
            child: Container(
              child: Center(
                child: Icon(Icons.done),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BackspaceKey extends OperationKey {
  const BackspaceKey({
    Key? key,
    final Function? onBackSpace,
  }) : super(
            key: key,
            icon: const Icon(Icons.backspace),
            onOperation: onBackSpace);
}

class EnterKey extends OperationKey {
  const EnterKey({
    Key? key,
    final Function? onEnter,
  }) : super(key: key, icon: const Icon(Icons.check), onOperation: onEnter);
}
