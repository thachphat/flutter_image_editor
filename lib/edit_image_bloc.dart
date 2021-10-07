import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_editor/image_repository.dart';
import 'package:photo_editor/models/image.dart';
import 'package:photo_editor/models/sticker.dart';

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

// TODO: remove last image when back to home

class EditImageBloc extends Cubit<EditImageEvent> {
  EditImageBloc() : super(const EditImageStarted());

  final _picker = ImagePicker();
  final _imageRepository = ImageRepository();
  MyImage? get lastImage => _imageRepository.lastImage;

  void pickImage() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    final image = MyImage(file.path);
    _imageRepository.addImage(image);
    emit(ImagePicked(image));
  }

  void addSticker(MyImage image, Sticker sticker) {
    _imageRepository.addSticker(image, sticker);
    emit(ImageStickerAdded(image, sticker));
  }

  void addStickerToLastImage(Sticker sticker) {
    final lastImage = this.lastImage;
    if (lastImage == null) {
      return;
    }
    addSticker(lastImage, sticker);
  }
}
