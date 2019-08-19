import 'dart:ui';
import 'package:flutter_bird/flutter_bird_game.dart';
import 'package:flame/sprite.dart';

class Bird {
  final FlutterBirdGame game;
  bool isDead = false;
  bool isOffScreen = false;
  Rect birdRect;
  List<Sprite> flyingSprite;
  List<String> flyName = [
    'agile',
    'house',
    'drooler',
    'hungry',
    'macho',
  ];
  double get speed => game.tileSize * 3;
  Offset targetLocation;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;

  Bird(this.game, double x, double y) {
    birdRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    flyingSprite = List<Sprite>();
    final name = flyName[game.rnd.nextInt(flyName.length)];
    flyingSprite.add(Sprite('flies/' + name + '-fly-1.png'));
    flyingSprite.add(Sprite('flies/' + name + '-fly-2.png'));
    deadSprite = Sprite('flies/' + name + '-fly-dead.png');
    setTargetLocation();
  }

  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(c, birdRect.inflate(2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()]
          .renderRect(c, birdRect.inflate(2));
    }
  }

  void update(double t) {
    if (isDead) {
      birdRect = birdRect.translate(0, game.tileSize * 12 * t);
      if (birdRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    } else {
      flyingSpriteIndex += 20 * t;
      if (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }
      double stepDistance = speed * t;
      Offset toTarget = targetLocation - Offset(birdRect.left, birdRect.top);
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget =
            Offset.fromDirection(toTarget.direction, stepDistance);
        birdRect = birdRect.shift(stepToTarget);
      } else {
        birdRect = birdRect.shift(toTarget);
        setTargetLocation();
      }
    }
  }

  void onTapDown() {
    isDead = true;
  }

  void setTargetLocation() {
    double x =
        game.rnd.nextDouble() * (game.screenSize.width - (game.tileSize));
    double y =
        game.rnd.nextDouble() * (game.screenSize.height - (game.tileSize));
    targetLocation = Offset(x, y);
  }
}
