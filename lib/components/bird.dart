import 'dart:ui';
import 'package:flutter_bird/flutter_bird_game.dart';

class Bird {
  final FlutterBirdGame game;
  bool isDead = false;
  bool isOffScreen = false;
  Rect birdRect;
  Paint birdPaint;

  Bird(this.game, double x, double y) {
    birdRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    birdPaint = Paint();
    birdPaint.color = Color(0xff6ab04c);
  }

  void render(Canvas c) {
    c.drawRect(birdRect, birdPaint);
  }

  void update(double t) {
    if (isDead) {
      birdRect = birdRect.translate(0, game.tileSize * 12 * t);
    }
    if (birdRect.top > game.screenSize.height) {
      isOffScreen = true;
    }
  }

  void onTapDown() {
    birdPaint.color = Color(0xffff4757);
    isDead = true;
  }
}
