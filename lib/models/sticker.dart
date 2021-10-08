import 'package:hive/hive.dart';

part 'sticker.g.dart';

@HiveType(typeId: 1)
class Sticker {
  Sticker(this.name,
      [this.scale = 1, this.angle = 0, this.dx = 0, this.dy = 0]);

  get assetName => 'images/$name.png';

  @HiveField(0)
  final String name;
  @HiveField(1)
  double scale;
  @HiveField(2)
  double angle;
  @HiveField(3)
  double dx;
  @HiveField(4)
  double dy;
}
