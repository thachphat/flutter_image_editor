import 'package:hive/hive.dart';
import 'package:photo_editor/models/sticker.dart';

part 'image.g.dart';

@HiveType(typeId: 0)
class MyImage {
  MyImage(this.id, this.path, [this.stickers = const []]);

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String path;
  @HiveField(2)
  List<Sticker> stickers;
}
