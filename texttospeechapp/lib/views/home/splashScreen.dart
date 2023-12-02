import 'package:flutter/material.dart';
import 'package:texttospeechapp/navbarScreen.dart';
import 'package:texttospeechapp/views/home/homeScreem.dart';

class splashScreenWidget extends StatefulWidget {
  const splashScreenWidget({super.key});

  @override
  State<splashScreenWidget> createState() => _splashScreenWidgetState();
}

class _splashScreenWidgetState extends State<splashScreenWidget> {
  @override
  void initState() {
    super.initState();
    _routeToHomeScreen();
  }

  _routeToHomeScreen() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const navBarScreenWidget(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 40, 58, 120),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 135,
                width: 135,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.record_voice_over,
                      size: 35,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 30,
                    ),
                    Icon(
                      Icons.description,
                      size: 35,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Speech to Text',
                style: TextStyle(fontSize: 24, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
