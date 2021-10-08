import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_editor/models/sticker.dart';

class StickerBloc extends Cubit<List<Sticker>> {
  StickerBloc() : super([]);

  void initAssetImages() {
    emit(List.generate(3, (index) => Sticker('sticker_${index + 1}')));
  }
}
