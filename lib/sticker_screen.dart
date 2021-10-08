import 'package:flutter/material.dart';
import 'package:photo_editor/edit_image_event.dart';
import 'package:photo_editor/models/sticker.dart';
import 'package:photo_editor/edit_image_bloc.dart';
import 'package:photo_editor/sticker_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StickerScreen extends StatelessWidget {
  const StickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<StickerBloc>().initAssetImages();
    return BlocListener<EditImageBloc, EditImageEvent>(
      listener: (_, event) {
        if (event is ImageStickerAdded) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<StickerBloc, List<Sticker>>(
        builder: (context, assets) => Scaffold(
          backgroundColor: Colors.white,
          body: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 3,
            // Generate 100 widgets that display their index in the List.
            children: assets
                .map(
                  (sticker) => GestureDetector(
                    onTap: () => context
                        .read<EditImageBloc>()
                        .addStickerToLastImage(sticker),
                    child: Center(
                        child: Image(image: AssetImage(sticker.assetName))),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
