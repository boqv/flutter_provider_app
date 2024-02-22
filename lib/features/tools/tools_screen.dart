import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
          width: double.infinity,
          height: 140,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tools",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                  "I don't know what to put here yet",
                  style: Theme.of(context).textTheme.labelLarge
              )
            ],
          ),
        )
      ],
    );
  }
}