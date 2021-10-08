import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_editor/edit_image/bloc/edit_image_bloc.dart';
import 'package:photo_editor/select_sticker/bloc/sticker_bloc.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => EditImageBloc()..onStarted()),
        BlocProvider(create: (_) => StickerBloc())
      ],
      child: const MaterialApp(
        title: 'Photo Editor',
        home: MyHomePage(),
      ),
    );
  }
}