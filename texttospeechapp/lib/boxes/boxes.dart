import 'package:hive/hive.dart';
import 'package:texttospeechapp/models/speech_models.dart';

class Boxes {
  static Box<speechModel> getData() => Hive.box<speechModel>('speeches');
}
