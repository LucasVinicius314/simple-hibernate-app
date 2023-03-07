import 'package:flutter/material.dart';
import 'package:simple_hibernate_app/modules/home_page.dart';
import 'package:simple_hibernate_app/utils/constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ).copyWith(secondary: Colors.blueAccent),
      ),
      routes: {
        HomePage.route: (context) => const HomePage(),
      },
    );
  }
}
