import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:texttospeechapp/colors/colors.dart';
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
  @override
  Widget build(BuildContext context) {
    var fontSizeProvider = Provider.of<FontSizeProvider>(context);
    stt.SpeechToText speech = stt.SpeechToText();

    var fontColorProvider = Provider.of<FontColorProvider>(context);
    // var fontColorProvider = Provider.of<FontColorProvider>(context);

    // List of available languages
    List<Map<String, dynamic>> languages = [
      {'name': 'English', 'localeId': 'en_US', 'flag': '🇺🇸'},
      {'name': 'Arabic', 'localeId': 'ar', 'flag': '🇸🇦'},
      {'name': 'Urdu', 'localeId': 'ur_PK', 'flag': '🇵🇰'},
      {'name': 'Russian', 'localeId': 'ru_RU', 'flag': '🇷🇺'},
      {'name': 'Chinese', 'localeId': 'zh_CN', 'flag': '🇨🇳'},
    ];

    // Function to start speech recognition
    void startListening() async {
      if (!speech.isListening) {
        bool available = await speech.initialize(
          onStatus: (val) => print('onStatus: $val'),
          onError: (val) => print('onError: $val'),
        );

        if (available) {
          // Set the selected language
          String selectedLocaleId = languages.firstWhere(
              (lang) => lang['name'] == selectedLanguage)['localeId'];

          speech.listen(
            onResult: (val) {
              setState(() {
                recognizedText = val.recognizedWords; // Update recognized text
                print('onResult: $val');
              });
            },
            localeId: selectedLocaleId,
          );
        }
      }
    }

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
                child: Container(
                  color: const Color.fromARGB(255, 226, 230, 247),
                  child: ListView.separated(
                    itemCount: languages.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.8,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                          languages[index]['name'],
                          style: TextStyle(
                              fontSize: fontSizeProvider.fontSize,
                              color: fontColorProvider.selectedColor),
                        ),
                        onTap: () {
                          setState(() {
                            selectedLanguage = languages[index]['name'];
                          });
                        },
                      );
                    },
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
