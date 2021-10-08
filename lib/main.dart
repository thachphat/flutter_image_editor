import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_editor/edit_image_screen.dart';
import 'package:photo_editor/edit_image_bloc.dart';
import 'package:photo_editor/sticker_bloc.dart';

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
        BlocProvider(create: (_) => EditImageBloc()),
        BlocProvider(create: (_) => StickerBloc())
      ],
      child: const MaterialApp(
        title: 'Photo Editor',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<EditImageBloc, EditImageEvent>(
          listener: (context, event) => _listenImage(context, event),
          child: Center(
            child: ElevatedButton(
              onPressed: () => context.read<EditImageBloc>().pickImage(),
              child: const Text('Pick Image'),
            ),
          ),
        ));
  }

  void _listenImage(BuildContext context, EditImageEvent event) {
    if (event is ImagePicked) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const EditImageScreen(),
          ));
    }
    if (event is NoPhotoPermission) {
      _showPhotoPermissionDialog(context);
    }
  }

  Future<void> _showPhotoPermissionDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please enable photo permission to use this app.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                AppSettings.openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
