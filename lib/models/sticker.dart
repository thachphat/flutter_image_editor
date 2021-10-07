class Sticker {
  Sticker(this.name,
      [this.scale = 1, this.angle = 0, this.dx = 0, this.dy = 0]);

  get assetName => 'images/$name.png';

  final String name;
  double scale;
  double angle;
  double dx;
  double dy;
}
