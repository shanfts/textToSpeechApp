import 'package:hive/hive.dart';
part 'speech_models.g.dart';

@HiveType(typeId: 0)
class speechModel extends HiveObject {
  @HiveField(0)
  String recognizedSpeeches;

  speechModel({required this.recognizedSpeeches});
}
