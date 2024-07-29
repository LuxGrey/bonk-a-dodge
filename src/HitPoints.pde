/**
 Responsible for rendering an animation of the points that the player received by hitting a target
 */
class HitPoints {
  /**
   Initially is the position of the mouse cursor when the target was last hit
   */
  PVector textPosition;
  String pointsText;
  color textColor;

  void init(PVector positionHit, int pointsForHit) {
    this.textPosition = positionHit;

    if (pointsForHit < 0) {
      // red for negative points
      textColor = color(237, 32, 22);
      pointsText = "" + pointsForHit;
    } else {
      // gold for positive points
      textColor = color(291, 199, 42);
      pointsText = "+" + pointsForHit;
    }
  }

  void render() {
    textAlign(CENTER, CENTER);
    textSize(50);
    fill(textColor);
    text(pointsText, textPosition.x, textPosition.y);

    // update position for animation
    textPosition.y -= 2;
  }
}
