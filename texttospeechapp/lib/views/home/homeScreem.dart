import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:texttospeechapp/boxes/boxes.dart';
import 'package:texttospeechapp/colors/colors.dart';
import 'package:texttospeechapp/models/speech_models.dart';
import 'package:texttospeechapp/views/common_widgets/colorProvider.dart';
import 'package:texttospeechapp/views/common_widgets/commonWidgets.dart';
import 'package:texttospeechapp/views/history/historyScreen.dart';
import 'package:texttospeechapp/views/settings/settingsScreen.dart';

class homeScreenWidget extends StatefulWidget {
  const homeScreenWidget({super.key});

  @override
  State<homeScreenWidget> createState() => _homeScreenWidgetState();
}

class _homeScreenWidgetState extends State<homeScreenWidget> {
  String selectedLanguage = 'English'; // Default selected language
  String recognizedText = '';
  bool isListening = false;
  List<String> recognizedTextList = [];
  stt.SpeechToText speech = stt.SpeechToText();

// List of available languages
  List<Map<String, dynamic>> languages = [
    {'name': 'English', 'localeId': 'en_US', 'flag': '🇺🇸'},
    {'name': 'Arabic', 'localeId': 'ar', 'flag': '🇸🇦'},
    {'name': 'Urdu', 'localeId': 'ur_PK', 'flag': '🇵🇰'},
    {'name': 'Russian', 'localeId': 'ru_RU', 'flag': '🇷🇺'},
    {'name': 'Chinese', 'localeId': 'zh_CN', 'flag': '🇨🇳'},
    {'name': 'Hindi', 'localeId': 'hi_IN', 'flag': '🇮🇳'}, // Added Hindi
  ];
// Import the intl package for date formatting

// ...

// Function to start speech recognition
  void startListening() async {
    if (!speech.isListening) {
      bool available = await speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );

      if (available) {
        // Set the selected language
        String selectedLocaleId = languages
            .firstWhere((lang) => lang['name'] == selectedLanguage)['localeId'];

        speech.listen(
          onResult: (val) {
            setState(() {
              if (val.finalResult) {
                String recognizedText =
                    val.recognizedWords; // Update recognized text

                // Get current date and time and format them
                String currentDate =
                    DateFormat('yyyy-MM-dd').format(DateTime.now());
                String currentTime =
                    DateFormat('HH:mm:ss').format(DateTime.now());

                // Create formatted date and time strings with adjusted font size
                String dateTimeText =
                    '$currentDate\n$currentTime'; // Date and time

                TextStyle dateStyle =
                    const TextStyle(fontSize: 14); // Date and time font size
                TextStyle textBelowStyle =
                    const TextStyle(fontSize: 16); // Recognized text font size

                recognizedTextList.add(
                  Column(
                    children: [
                      Text(dateTimeText, style: dateStyle),
                      Text(recognizedText, style: textBelowStyle),
                    ],
                  ) as String,
                );

                final data = speechModel(recognizedSpeeches: recognizedText);
                final box = Boxes.getData();

                box.add(data);
                data.save();
                print(box);
              }
              print('onResult: $val');
            });
          },
          localeId: selectedLocaleId,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var fontSizeProvider = Provider.of<FontSizeProvider>(context);
    var fontColorProvider = Provider.of<FontColorProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.history,
                  size: 30,
                  color: Colors.white,
                ))
          ],
          toolbarHeight: 70,
          backgroundColor: primaryBackground,
          title: const Text(
            'Speech to Text',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 5),
                            blurRadius: 15)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 25),
                    child: DropdownButtonFormField(
                      borderRadius: BorderRadius.circular(15),
                      decoration: const InputDecoration(
                          enabled: false, disabledBorder: InputBorder.none),
                      value: selectedLanguage,
                      iconSize: 35,
                      items: languages.map((lang) {
                        return DropdownMenuItem(
                          value: lang['name'],
                          child: Row(
                            children: [
                              Text(
                                lang['flag'],
                                style: const TextStyle(fontSize: 25),
                              ), // Display flag
                              const SizedBox(width: 8),
                              Text(
                                lang['name'],
                                style: const TextStyle(fontSize: 20),
                              ), // Display language name
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value.toString();
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Button for speech recognition
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 226, 230, 247),
                        borderRadius: BorderRadius.circular(15)),
                    child: Scrollbar(
                      trackVisibility: true,
                      radius: const Radius.circular(15),
                      child: ValueListenableBuilder<Box<speechModel>>(
                        valueListenable: Boxes.getData().listenable(),
                        builder: (context, box, _) {
                          var data = box.values.toList().cast<speechModel>();
                          return ListView.separated(
                            itemCount: box.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              indent: 10,
                              height: 1,
                              endIndent: 10,
                              thickness: 0.8,
                              color: primaryBackground,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(
                                  data[index].recognizedSpeeches.toString(),
                                  style: TextStyle(
                                      fontSize: fontSizeProvider.fontSize,
                                      color: fontColorProvider.selectedColor),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 30, left: 40, right: 40),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(5, 8),
                              spreadRadius: 1,
                              blurRadius: 15)
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Tap to Speak',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 40, 58, 120)),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: AvatarGlow(
                            endRadius: 75,
                            animate: isListening,
                            duration: const Duration(milliseconds: 2000),
                            glowColor: primaryBackground,
                            repeat: true,
                            repeatPauseDuration:
                                const Duration(milliseconds: 100),
                            showTwoGlows: true,
                            child: GestureDetector(
                              onTap: startListening,
                              onTapDown: (details) {
                                setState(() {
                                  isListening = true;
                                });
                              },
                              onTapUp: (details) {
                                setState(() {
                                  isListening = false;
                                });
                              },
                              child: const SizedBox(
                                height: 80,
                                width: 80,
                                child: CircleAvatar(
                                  backgroundColor: primaryBackground,
                                  child: Icon(
                                    Icons.mic,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  // IconButton(
                                  //   onPressed: startListening,
                                  //   icon: const Icon(
                                  //     Icons.mic,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
