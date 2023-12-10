import 'package:hive/hive.dart';
part 'speech_models.g.dart';

@HiveType(typeId: 0)
class speechModel extends HiveObject {
  @HiveField(0)
  String recognizedSpeeches;

  @HiveField(1)
  String dateAndTime;

  speechModel({required this.recognizedSpeeches, required this.dateAndTime});
}
