/**
 An instance of this class represents both a hole where a target can appear
 as well as the target itself.
 This means that depending on its state, an instance can be an unoccupied hole
 or an active target, with corresponding changes in appearance and behavior.
 */
class Target {
  // constant that defines the size of an target's hitbox
  private static final int TARGET_RADIUS = 130;
  // how long a target will remain in an active state before returning to inactive if it is not hit
  private static final int DURATION_ACTIVE = 2000;
  // how long a target will be displayed as hit before returning to inactive
  private static final int DURATION_HIT = 1000;
  private static final int DURATION_SPRITE_ENTERING = 30;
  private static final int DURATION_SPRITE_LEAVING = 30;
  private static final int MIN_WAIT_ACTIVATION = 2000;
  private static final int MAX_WAIT_ACTIVATION = 5000;
  private static final int MIN_WAIT_ACTIVATION_START = 1000;
  private static final int MAX_WAIT_ACTIVATION_START = 6000;
  private static final int POINTS_POSITIVE = 100;
  private static final int POINTS_NEGATIVE = -500;
  // amount of different sprites for target movement animation
  private static final int AMOUNT_SPRITES_MOVEMENT = 9;
  private static final int SPRITE_WIDTH = 300;
  private static final int SPRITE_HEIGHT = 300;
  private static final int DURATION_ENTERING = DURATION_SPRITE_ENTERING * AMOUNT_SPRITES_MOVEMENT;
  private static final int DURATION_LEAVING = DURATION_SPRITE_LEAVING * AMOUNT_SPRITES_MOVEMENT;

  /**
   The position of a target is oriented at its center
   */
  PVector position;
  TargetState targetState;
  int timeOfLastActivation;
  int timeOfLastHit;
  int timeOfNextActivation;
  boolean isNegativeTarget;

  PImage targetPositive;
  PImage targetNegative;
  PImage holeBack;
  PImage holeFront;
  PImage activeSprite;

  Target(PVector position, PImage holeBack, PImage holeFront, PImage targetPositive, PImage targetNegative) {
    this.position = position;
    this.holeBack = holeBack;
    this.holeFront = holeFront;
    this.targetPositive = targetPositive;
    this.targetNegative = targetNegative;
    this.activeSprite = null;
  }

  /**
   This method should be called right before every every gameplay round to
   reset this instance to its initial state.
   */
  void init() {
    targetState = TargetState.INACTIVE;
    isNegativeTarget = false;
    activeSprite = targetPositive;
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
    imageMode(CENTER);
    image(holeBack, position.x, position.y);
    
    switch (this.targetState) {
    case ACTIVE:
      // assume by default that target is not in a movement animation
      int spriteOffsetMovement = AMOUNT_SPRITES_MOVEMENT - 1;
      int timeSinceActivation = millis() - timeOfLastActivation;
      if (timeSinceActivation < DURATION_ENTERING) {
        spriteOffsetMovement = timeSinceActivation / DURATION_SPRITE_ENTERING;
      } else if (timeSinceActivation > DURATION_ACTIVE - DURATION_LEAVING) {
        // target is leaving
        spriteOffsetMovement = (DURATION_ACTIVE - timeSinceActivation) / DURATION_SPRITE_LEAVING;
      }
    
      PImage sprite = activeSprite.get(0, SPRITE_HEIGHT * spriteOffsetMovement, SPRITE_WIDTH, SPRITE_HEIGHT);
      image(sprite, position.x, position.y);

      if ((this.timeOfLastActivation + DURATION_ACTIVE) < millis()) {
        changeState(TargetState.INACTIVE);
      }
      break;
    case INACTIVE:
      if (this.timeOfNextActivation < millis()) {
        changeState(TargetState.ACTIVE);
      }
      break;
    case HIT:
      if ((this.timeOfLastHit + DURATION_HIT) < millis()) {
        changeState(TargetState.INACTIVE);
      }
      break;
    }
    
    image(holeFront, position.x, position.y);
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
      activeSprite = isNegativeTarget ? targetNegative : targetPositive;
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
