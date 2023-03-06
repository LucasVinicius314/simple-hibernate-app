import 'package:flutter/material.dart';
import 'package:simple_hibernate_app/modules/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Hibernate App',
      routes: {
        HomePage.route: (context) => const HomePage(),
      },
    );
  }
}
