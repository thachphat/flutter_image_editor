import '../../models/image.dart';
import '../../models/sticker.dart';

abstract class EditImageEvent {
  const EditImageEvent();
}

class EditImageStarted extends EditImageEvent {
  const EditImageStarted();
}

class ImagePicked extends EditImageEvent {
  const ImagePicked(this.image) : super();
  final MyImage image;
}

class ImageStickerAdded extends EditImageEvent {
  const ImageStickerAdded(this.image, this.sticker) : super();
  final MyImage image;
  final Sticker sticker;
}

class NoPhotoPermission extends EditImageEvent {
  const NoPhotoPermission();
}

class DraftImageChanges extends EditImageEvent {
  const DraftImageChanges(this.images);

  final List<MyImage> images;
}
