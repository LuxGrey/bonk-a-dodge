/**
 An instance of this class represents both a hole where a target can appear
 as well as the target itself.
 This means that depending on its state, an instance can be an unoccupied hole
 or an active target, with corresponding changes in appearance and behavior.
 */
class Target {
  // constant that defines the size of an target's hitbox
  private static final int TARGET_RADIUS = 100;
  // how long a target will remain in an active state before returning to inactive if it is not hit
  private static final int DURATION_ACTIVE = 2000;
  // how long a target will be displayed as hit before returning to inactive
  private static final int DURATION_HIT = 1000;
  private static final int MIN_WAIT_ACTIVATION = 2000;
  private static final int MAX_WAIT_ACTIVATION = 5000;
  private static final int MIN_WAIT_ACTIVATION_START = 1000;
  private static final int MAX_WAIT_ACTIVATION_START = 6000;
  private static final int POINTS_POSITIVE = 100;
  private static final int POINTS_NEGATIVE = -500;

  TargetState targetState;
  int timeOfLastActivation;
  int timeOfLastHit;
  int timeOfNextActivation;
  boolean isNegativeTarget;

  /**
   The position of a target is oriented at its center
   */
  PVector position;

  Target(PVector position) {
    this.position = position;
  }

  /**
   This method should be called right before every every gameplay round to
   reset this instance to its initial state.
   */
  void init() {
    targetState = TargetState.INACTIVE;
    isNegativeTarget = false;
    timeOfNextActivation = millis() + (int)random(MIN_WAIT_ACTIVATION_START, MAX_WAIT_ACTIVATION_START);
  }

  /**
   If the target was hit, executes appropriate logic and returns true.
   Otherwise returns false.
   */
  boolean checkHit(PVector mousePosition) {
    if (this.targetState == TargetState.ACTIVE
      && isWithinHitbox(mousePosition)) {
      // TODO add logic for when target is hit
      changeState(TargetState.HIT);
      return true;
    }

    return false;
  }
  
  int getPointsForHit() {
    return isNegativeTarget ? POINTS_NEGATIVE : POINTS_POSITIVE;
  }

  void render() {
    // TODO replace placeholder circle with actual sprites and animations
    switch (this.targetState) {
    case ACTIVE:
      if (isNegativeTarget) {
        fill(40, 115, 232);
      } else {
        fill(250, 13, 40);
      }

      if ((this.timeOfLastActivation + DURATION_ACTIVE) < millis()) {
        changeState(TargetState.INACTIVE);
      }
      break;
    case INACTIVE:
      fill(120, 120, 120);
      if (this.timeOfNextActivation < millis()) {
        changeState(TargetState.ACTIVE);
      }
      break;
    case HIT:
      fill(23, 250, 13);
      if ((this.timeOfLastHit + DURATION_HIT) < millis()) {
        changeState(TargetState.INACTIVE);
      }
      break;
    }
    ellipseMode(RADIUS);
    ellipse(position.x, position.y, TARGET_RADIUS, TARGET_RADIUS);
  }

  void changeState(TargetState newState) {
    switch (newState) {
    case ACTIVE:
      this.timeOfLastActivation = millis();
      break;
    case HIT:
      this.timeOfLastHit = millis();
      break;
    case INACTIVE:
      // prepare for next activation

      // 1 in 10 chance of being negative target
      isNegativeTarget = (int)random(8) == 0;
      this.timeOfNextActivation = millis() + (int)random(MIN_WAIT_ACTIVATION, MAX_WAIT_ACTIVATION);
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
