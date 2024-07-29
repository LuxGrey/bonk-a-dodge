/**
 An instance of this class represents both a hole where a target can appear
 as well as the target itself.
 This means that depending on its state, an instance can be an unoccupied hole
 or an active target, with corresponding changes in appearance and behavior.
 */
class Target {
  // constant that defines the size of an target's hitbox
  static final int TARGET_RADIUS = 100;
  // how long a target will remain in an active state before returning to inactive if it is not hit
  static final int DURATION_ACTIVE = 2000;
  // how long a target will be displayed as hit before returning to inactive
  static final int DURATION_HIT = 1000;
  TargetState targetState;
  int points;
  // the timestamp at which the target last became active
  int timeActive;
  // the timestamp at which the target was last hit
  int timeHit;

  /**
   The position of a target is oriented at its center
   */
  PVector position;

  Target(PVector position) {
    this.position = position;
    this.points = 100;
  }

  /**
   This method should be called right before every every gameplay round to
   reset this instance to its initial state.
   */
  void init() {
    switchState(TargetState.INACTIVE);
  }

  /**
   If the target was hit, executes appropriate logic and returns true.
   Otherwise returns false.
   */
  boolean checkHit(PVector mousePosition) {
    if (this.targetState == TargetState.ACTIVE
      && isWithinHitbox(mousePosition)) {
      // TODO add logic for when target is hit
      switchState(TargetState.HIT);
      return true;
    }

    return false;
  }

  void render() {
    // TODO replace placeholder circle with actual sprites and animations
    switch (this.targetState) {
    case ACTIVE:
      if ((this.timeActive + DURATION_ACTIVE) < millis()) {
        switchState(TargetState.INACTIVE);
      }
      fill(250, 13, 40);
      break;
    case INACTIVE:
      fill(120, 120, 120);
      break;
    case HIT:
      if ((this.timeHit + DURATION_HIT) < millis()) {
        switchState(TargetState.INACTIVE);
      }
      fill(23, 250, 13);
      break;
    }
    ellipseMode(RADIUS);
    ellipse(position.x, position.y, TARGET_RADIUS, TARGET_RADIUS);
  }

  void switchState(TargetState newState) {
    switch (newState) {
    case ACTIVE:
      this.timeActive = millis();
      break;
    case HIT:
      this.timeHit = millis();
      break;
    case INACTIVE:
      // no special behavior
      break;
    }

    this.targetState = newState;
  }

  /**
   Determines whether the mouse cursor is within the hitbox of the target
   */
  private boolean isWithinHitbox(PVector mousePosition) {
    return this.position.dist(mousePosition) < TARGET_RADIUS;
  }
}
