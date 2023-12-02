import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:texttospeechapp/navbarScreen.dart';
import 'package:texttospeechapp/views/home/splashScreen.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 40, 58, 120),
      statusBarIconBrightness: Brightness.light));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const splashScreenWidget(),
    );
  }
}
