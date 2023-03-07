import 'package:flutter/material.dart';
import 'package:simple_hibernate_app/utils/constants.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.appName)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
