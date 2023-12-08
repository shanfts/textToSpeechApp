import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texttospeechapp/colors/colors.dart';
import 'package:texttospeechapp/models/language_model.dart';
import 'package:texttospeechapp/views/common_widgets/colorProvider.dart';

import '../common_widgets/commonWidgets.dart';

class settingScreenWidget extends StatefulWidget {
  const settingScreenWidget({super.key});

  @override
  State<settingScreenWidget> createState() => _settingScreenWidgetState();
}

class _settingScreenWidgetState extends State<settingScreenWidget> {
  double fontSize = 18.0;

  @override
  Widget build(BuildContext context) {
    var fontColorProvider = Provider.of<FontColorProvider>(context);
    var fontSizeProvider = Provider.of<FontSizeProvider>(context);

    var languageProvider = Provider.of<LanguageProvider>(context);
    String selectedLanguage = 'English';
    // Initial font size
    List<Color> colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
    ];
    List<Map<String, dynamic>> languages = [
      {'name': 'English', 'localeId': 'en_US', 'flag': '🇺🇸'},
      {'name': 'Arabic', 'localeId': 'ar', 'flag': '🇸🇦'},
      {'name': 'Urdu', 'localeId': 'ur_PK', 'flag': '🇵🇰'},
      {'name': 'Russian', 'localeId': 'ru_RU', 'flag': '🇷🇺'},
      {'name': 'Chinese', 'localeId': 'zh_CN', 'flag': '🇨🇳'},
    ];
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: primaryBackground,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 95,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text(
                        'Recognition Language',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    DropdownButtonFormField(
                      borderRadius: BorderRadius.circular(15),
                      decoration: const InputDecoration(
                          enabled: false, disabledBorder: InputBorder.none),
                      value: languageProvider.selectedLanguage,
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
                        languageProvider.setSelectedLanguage(value.toString());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: double.infinity,
              height: 190,
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
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Appearance',
                      style: TextStyle(fontSize: 16, color: primaryBackground),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.text_fields,
                          color: primaryBackground,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Font Size',
                          style: TextStyle(fontSize: fontSizeProvider.fontSize),
                        )
                      ],
                    ),
                    Slider(
                      activeColor: primaryBackground,
                      value: fontSizeProvider.fontSize,
                      min: 12,
                      max: 25,
                      divisions: 5,
                      label: fontSize.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          fontSizeProvider.setFontSize(value);
                        });
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'A',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'A',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: double.infinity,
              height: 150,
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
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Color Scheme',
                      style: TextStyle(fontSize: 16, color: primaryBackground),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.palette,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Enjoy Multple Colors',
                          style:
                              TextStyle(fontSize: 16, color: primaryBackground),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 50, // Set a fixed height for the horizontal list
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: colors.map((Color color) {
                          return GestureDetector(
                            onTap: () {
                              fontColorProvider.setFontColor(color);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(15)),
                                child: fontColorProvider.selectedColor == color
                                    ? const Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
