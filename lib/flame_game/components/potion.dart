import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../endless_world.dart';

/// The [Potion] components are the components that the [Player] should collect
/// to finish a level. The points are represented by Flame's mascot; Ember.
class Potion extends SpriteComponent
    with HasGameReference, HasWorldReference<EndlessWorld> {
  Potion() : super(size: spriteSize, anchor: Anchor.center);

  static final Vector2 spriteSize = Vector2.all(200);

  factory Potion.random({
     Random? random,
  }) =>
      Potion();
      

  @override
  Future<void> onLoad() async {
    // Since all the obstacles reside in the same image, srcSize and srcPosition
    // are used to determine what part of the image that should be used.
    sprite = await Sprite.load(
      'potion.png',
      // srcSize: Vector2.all(200),
      // srcPosition: Vector2(48, 32),
    );
    // When adding a RectangleHitbox without any arguments it automatically
    // fills up the size of the component.
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    // We need to move the component to the left together with the speed that we
    // have set for the world plus the speed set for the point, so that it
    // is visually moving to the left in the world.
    // `dt` here stands for delta time and it is the time, in seconds, since the
    // last update ran. We need to multiply the speed by `dt` to make sure that
    // the speed of the obstacles are the same no matter the refresh rate/speed
    // of your device.
    position.x -= world.speed * dt;

    // When the component is no longer visible on the screen anymore, we
    // remove it.
    // The position is defined from the upper left corner of the component (the
    // anchor) and the center of the world is in (0, 0), so when the components
    // position plus its size in X-axis is outside of minus half the world size
    // we know that it is no longer visible and it can be removed.
    if (position.x + size.x / 2 < -world.size.x / 2) {
      removeFromParent();
    }
  }
}
