/**
An instance of this class represents both a hole where a target can appear
as well as the target itself.
This means that depending on its state, an instance can be an unoccupied hole
or an active target, with corresponding changes in appearance and behavior.
*/
class Hole {
  // constants that define the size of an instance's hitbox
  static final int radius = 100;
  
  boolean isActiveTarget;
  boolean wasHit;
  int points;
  
  /**
  The position of an instance is oriented at its center
  */
  PVector position;
  
  Hole(PVector position) {
    this.position = position;
    init();
  }
  
  void init() {
    this.isActiveTarget = false;
    this.wasHit = false;
    this.points = 100;
  }
  
  boolean checkHit(PVector hitPosition) {
    if (isWithinHitbox(hitPosition)) {
      // TODO add logic for when target is hit
      this.wasHit = !this.wasHit;
      return true;
    }
    
    return false;
  }
  
  void render() {
    // TODO replace placeholder circle with actual sprites and animations
    fill(49, 36, 209);
    if (this.wasHit) {
      fill(31, 203, 92);
    }
    ellipseMode(RADIUS);
    ellipse(position.x, position.y, radius, radius);
  }
  
  /**
  Determines whether the position expressed by the 2 arguments
  is within the the hitbox of the instance.
  */
  private boolean isWithinHitbox(PVector hitPosition) {
    return this.position.dist(hitPosition) < radius;
  }
}
