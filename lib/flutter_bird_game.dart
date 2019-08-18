import 'dart:ui';
import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter_bird/components/bird.dart';
import 'package:flutter_bird/components/background.dart';
import 'package:flutter/gestures.dart';

class FlutterBirdGame extends Game {
  List<Bird> birds;
  Background background;
  Size screenSize;
  double tileSize;
  Random rnd;

  FlutterBirdGame() {
    initialise();
  }

  void initialise() async {
    birds = List<Bird>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());
    background = new Background(this);
    spawnBird();
  }

  void render(Canvas canvas) {
    // Background
    background.render(canvas);

    //Birds
    birds.forEach((Bird bird) => bird.render(canvas));
  }

  void update(double t) {
    birds.forEach((Bird bird) => bird.update(t));
    birds.removeWhere((Bird bird) => bird.isOffScreen);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    bool isTapped = false;
    birds.forEach((Bird bird) {
      if (bird.birdRect.contains(d.globalPosition)) {
        bird.onTapDown();
        isTapped = true;
      }
    });
    if (isTapped) spawnBird();
  }

  void spawnBird() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = rnd.nextDouble() * (screenSize.height - tileSize);
    birds.add(Bird(this, x, y));
  }
}
