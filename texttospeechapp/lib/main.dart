import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:texttospeechapp/models/language_model.dart';
import 'package:texttospeechapp/models/sorting_model.dart';
import 'package:texttospeechapp/models/speech_models.dart';
import 'package:texttospeechapp/models/switch_model.dart';
import 'package:texttospeechapp/navbarScreen.dart';
import 'package:texttospeechapp/views/common_widgets/colorProvider.dart';
import 'package:texttospeechapp/views/common_widgets/commonWidgets.dart';
import 'package:texttospeechapp/views/home/homeScreem.dart';
import 'package:texttospeechapp/views/home/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(speechModelAdapter());
  await Hive.openBox<speechModel>('speeches');
  runApp(
    const MyApp(),
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 40, 58, 120),
      statusBarIconBrightness: Brightness.light));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FontColorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FontSizeProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ViewMode()),
        ChangeNotifierProvider(
          create: (context) => SortOptionNotifier(),
        ),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const splashScreenWidget(),
          '/home': (context) => const homeScreenWidget()
        },
      ),
    );
  }
}
