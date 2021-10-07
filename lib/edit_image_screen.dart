import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_editor/edit_image_bloc.dart';
import 'package:photo_editor/sticker_bloc.dart';
import 'package:photo_editor/sticker_screen.dart';
import 'package:photo_editor/sticker_widget.dart';

class EditImageScreen extends StatelessWidget {
  const EditImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          BlocBuilder<EditImageBloc, EditImageEvent>(builder: (context, event) {
        var views = <Widget>[];
        // TODO: find a way to recreate image + stickers
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
          // TODO: add sticker to screen
        }
        return Stack(
          children: views,
        );
      }),
      // Center(
      //   child: Image.file(File(_path)),
      // ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showStickerScreen(context),
      ),
    );
  }

  void _showStickerScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(providers: [
          BlocProvider(create: (_) => StickerBloc()),
          BlocProvider(create: (_) => context.read<EditImageBloc>()),
        ], child: const StickerScreen()),
      ),
    );
  }
}
