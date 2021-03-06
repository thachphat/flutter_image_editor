import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_editor/edit_image/bloc/edit_image_bloc.dart';
import 'package:photo_editor/select_sticker/views/sticker_screen.dart';
import 'package:photo_editor/edit_image/views/sticker_widget.dart';

import '../bloc/edit_image_event.dart';

class EditImageScreen extends StatelessWidget {
  const EditImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          BlocBuilder<EditImageBloc, EditImageEvent>(builder: (context, event) {
        var views = <Widget>[];
        final image = context.read<EditImageBloc>().lastImage;
        if (image == null) {
          views = [const Text('Please go back and add image')];
        } else {
          views = [
            Center(
              child: Image.file(File(image.path)),
            )
          ];
          views.addAll(
              image.stickers.map((sticker) => StickerWidget(sticker: sticker)));
        }
        return Stack(
          children: views,
        );
      }),
      // Center(
      //   child: Image.file(File(_path)),
      // ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => _showStickerScreen(context),
            heroTag: null,
          ),
          FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () {
              context.read<EditImageBloc>().saveDraftImage();
              Navigator.pop(context);
            },
            heroTag: null,
          ),
        ],
      ),
    );
  }

  void _showStickerScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const StickerScreen(),
      ),
    );
  }
}
