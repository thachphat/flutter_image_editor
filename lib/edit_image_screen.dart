import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditImageScreen extends StatelessWidget {
  const EditImageScreen(Key? key, this._path) : super(key: key);

  final String _path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.file(File(_path)),
      ),
    );
  }
}
