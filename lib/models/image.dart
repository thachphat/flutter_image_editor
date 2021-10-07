import 'package:photo_editor/models/sticker.dart';

class MyImage {
  MyImage(this.path, [this.stickers = const []]);
  final String path;
  List<Sticker> stickers;
}