import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_editor/models/image.dart';
import 'package:photo_editor/models/sticker.dart';

class ImageRepository {
  List<MyImage> _images = [];

  MyImage? get lastImage => _images.last;
  final _boxName = 'imageBox';

  Future<ImageRepository> setup() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MyImageAdapter());
    Hive.registerAdapter(StickerAdapter());
    await Hive.openBox(_boxName);
    return this;
  }

  void addImage(MyImage image) => _images = [..._images, image];

  void addSticker(MyImage image, Sticker sticker) =>
      image.stickers = [...image.stickers, sticker];

  void saveDraftImage(MyImage image) async {
    final draft = await loadDraftImages();
    final index = draft.indexWhere((element) {
      return element.id == image.id;
    });
    if (index == -1) {
      draft.add(image);
    } else {
      draft.replaceRange(index, index + 1, [image]);
    }
    final box = await Hive.openBox(_boxName);
    box.put('draft', draft);
  }

  void imageSelected(MyImage image) {
    _images = [image];
  }

  Future<List<MyImage>> loadDraftImages() async {
    final box = await Hive.openBox(_boxName);
    final images = box.get('draft', defaultValue: <MyImage>[]);
    return images.cast<MyImage>();
  }
}
