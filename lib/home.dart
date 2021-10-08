import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_editor/edit_image_bloc.dart';
import 'package:photo_editor/edit_image_event.dart';

import 'edit_image_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<EditImageBloc, EditImageEvent>(
        listener: (context, event) => _listenImage(context, event),
        child: BlocBuilder<EditImageBloc, EditImageEvent>(
          buildWhen: (_, event) => event is DraftImageChanges,
          builder: (context, event) {
            if (event is DraftImageChanges) {
              return ListView(
                children: event.images
                    .map(
                      (image) => ListTile(
                        leading: const Icon(Icons.photo_album),
                        title: Text(image.id.toString()),
                        onTap: () =>
                            context.read<EditImageBloc>().imageSelected(image),
                      ),
                    )
                    .toList(),
              );
            }
            return const Center(
              child: Text('Try adding some amazing images'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<EditImageBloc>().pickImage(),
        child: const Icon(Icons.add),
      ),
    );
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
