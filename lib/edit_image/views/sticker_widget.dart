import 'package:flutter/material.dart';
import '../../models/sticker.dart';

class StickerWidget extends StatefulWidget {
  const StickerWidget({Key? key, required this.sticker}) : super(key: key);

  final Sticker sticker;

  @override
  State<StatefulWidget> createState() => _StickerWidgetState();
}

class _StickerWidgetState extends State<StickerWidget> {
  double defaultScale = 1.0;
  double defaultRotation = 0.0;
  double defaultX = 0.0;
  double defaultY = 0.0;
  late ScaleUpdateDetails scaleStart;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform:
          Matrix4.translationValues(widget.sticker.dx, widget.sticker.dy, 0)
            ..scale(widget.sticker.scale, widget.sticker.scale)
            ..rotateZ(widget.sticker.angle),
      child: GestureDetector(
        onScaleStart: (_) {
          defaultScale = widget.sticker.scale;
          defaultRotation = widget.sticker.angle;
          defaultX = widget.sticker.dx;
          defaultY = widget.sticker.dy;
        },
        onScaleUpdate: (details) {
          setState(() {
            widget.sticker.scale =
                (defaultScale * details.scale).clamp(0.5, 1.5);
            widget.sticker.angle = defaultRotation + details.rotation;
            widget.sticker.dx = defaultX + details.delta.dx;
            widget.sticker.dy = defaultY + details.delta.dy;
          });
        },
        child: Image(image: AssetImage(widget.sticker.assetName)),
      ),
    );
  }
}
