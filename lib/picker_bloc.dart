import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PickerCubit extends Cubit<String?> {
  PickerCubit() : super(null);

  final _picker = ImagePicker();

  void pickImage() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    emit(file.path);
  }
}
