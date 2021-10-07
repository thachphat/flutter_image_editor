import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_editor/picker_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Photo Editor',
        home: BlocProvider(
          create: (_) => PickerCubit(),
          child: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<PickerCubit, String?>(
          builder: (context, image) => _createView(context, image)),
    );
  }

  Widget _createView(BuildContext context, String? path) {
    // TODO: navigate to image screen
    if (path == null) {
      return Center(
        child: ElevatedButton(
          onPressed: () => context.read<PickerCubit>().pickImage(),
          child: const Text('Pick Image'),
        ),
      );
    }
    return Center(
      child: Image.file(File(path)),
    );
  }
}
