import 'package:photo_editor/models/image.dart';
import 'package:photo_editor/models/sticker.dart';

class ImageRepository {
  List<MyImage> _images = [];

  MyImage? get lastImage => _images.last;

  void addImage(MyImage image) => _images = [..._images, image];

  void addSticker(MyImage image, Sticker sticker) =>
      image.stickers = [...image.stickers, sticker];
}
