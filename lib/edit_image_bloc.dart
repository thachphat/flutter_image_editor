import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_editor/image_repository.dart';
import 'package:photo_editor/models/image.dart';
import 'package:photo_editor/models/sticker.dart';

import 'edit_image_event.dart';

// TODO: remove last image when back to home

class EditImageBloc extends Cubit<EditImageEvent> {
  EditImageBloc() : super(const EditImageStarted());

  final _picker = ImagePicker();
  final _imageRepository = ImageRepository();

  MyImage? get lastImage => _imageRepository.lastImage;

  void onStarted() async {
    await _imageRepository.setup();
    loadDraftImages();
  }

  void pickImage() async {
    final status = await Permission.photos.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      emit(const NoPhotoPermission());
      return;
    }
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    final image = MyImage(DateTime.now().millisecondsSinceEpoch, file.path);
    _imageRepository.addImage(image);
    imageSelected(image);
  }

  void imageSelected(MyImage image) {
    _imageRepository.imageSelected(image);
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

  void saveDraftImage() {
    final lastImage = this.lastImage;
    if (lastImage == null) {
      return;
    }
    _imageRepository.saveDraftImage(lastImage);
    loadDraftImages();
  }

  void loadDraftImages() async {
    final images = await _imageRepository.loadDraftImages();
    emit(DraftImageChanges(images));
  }
}
