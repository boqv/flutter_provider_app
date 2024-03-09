import 'package:flutter/material.dart';

Future<void> errorDialog(
    BuildContext context,
    ViewError error,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(error.title),
          content: Text(error.message),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
  );
}

class ViewError {
  ViewError(this.title, this.message);

  final String title;
  final String message;

  @override
  bool operator ==(Object other) {
    return other is ViewError &&
        other.title == title &&
        other.message == message;
  }

  @override
  int get hashCode => Object.hash(title, message);
}
