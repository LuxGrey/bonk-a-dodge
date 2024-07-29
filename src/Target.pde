/**
 An instance of this class represents both a hole where a target can appear
 as well as the target itself.
 This means that depending on its state, an instance can be an unoccupied hole
 or an active target, with corresponding changes in appearance and behavior.
 */
class Target {
  private static final int POINTS_POSITIVE = 100;
  private static final int POINTS_NEGATIVE = -500;

  // constant that defines the size of the circular target hitbox
  private static final int TARGET_RADIUS = 130;

  // constants for timing target state changes
  private static final int MIN_WAIT_ACTIVATION = 2000;
  private static final int MAX_WAIT_ACTIVATION = 5000;
  // different timings at the start of a gameplay round
  private static final int MIN_WAIT_ACTIVATION_START = 1000;
  private static final int MAX_WAIT_ACTIVATION_START = 6000;
  // how long a target will remain in an active state before returning to inactive if it is not hit
  private static final int DURATION_ACTIVE = 1000;

  // constants for target sprite animations
  // amount of different sprites for target animations
  private static final int AMOUNT_SPRITES_MOVEMENT = 9;
  private static final int AMOUNT_SPRITES_FADEOUT = 9;
  private static final int SPRITE_WIDTH = 300;
  private static final int SPRITE_HEIGHT = 300;
  // durations for how long animation frames should be displayed
  private static final int DURATION_FRAME_ENTERING = 30;
  private static final int DURATION_FRAME_LEAVING = 30;
  private static final int DURATION_FRAME_FADEOUT = 30;
  // durations for complete animations
  private static final int DURATION_ENTERING = DURATION_FRAME_ENTERING * AMOUNT_SPRITES_MOVEMENT;
  private static final int DURATION_LEAVING = DURATION_FRAME_LEAVING * AMOUNT_SPRITES_MOVEMENT;
  private static final int DURATION_FADEOUT = DURATION_FRAME_FADEOUT * AMOUNT_SPRITES_FADEOUT;

  /**
   The position of a target is oriented at its center
   */
  PVector position;
  TargetState targetState;
  boolean isNegativeTarget;
  HitPoints hitPoints;

  // various timestamps
  int timeOfLastActivation;
  int timeOfLastHit;
  int timeOfNextActivation;

  PImage spriteSheetMovement;
  PImage spriteSheetFadeout;

  Target(PVector position) {
    hitPoints = new HitPoints();
    this.position = position;
    this.spriteSheetMovement = null;
    this.spriteSheetFadeout = null;
  }

  /**
   This method should be called right before every every gameplay round to
   reset this instance to its initial state.
   A target always starts off as positive and inactive.
   */
  void init() {
    targetState = TargetState.INACTIVE;
    isNegativeTarget = false;
    spriteSheetMovement = BonkADoge.images.targetPositiveMovement;
    spriteSheetFadeout = BonkADoge.images.targetPositiveFadeout;
    timeOfNextActivation = millis() + (int)random(MIN_WAIT_ACTIVATION_START, MAX_WAIT_ACTIVATION_START);
  }

  /**
   If the target was hit, executes appropriate logic and returns true.
   Otherwise returns false.
   */
  boolean checkHit(PVector mousePosition) {
    if (this.targetState == TargetState.ACTIVE
      && isWithinHitbox(mousePosition)) {
      hitPoints.init(mousePosition, getPointsForHit());
      changeState(TargetState.HIT);
      return true;
    }

    return false;
  }

  /**
   Determine the points that the player should receive for hitting this target
   */
  int getPointsForHit() {
    return isNegativeTarget ? POINTS_NEGATIVE : POINTS_POSITIVE;
  }

  /**
   Render target based on current target state and animation timings.
   When inactive, a target is an empty hole.
   When active, a target is first emerging from a hole, remaining for a moment and then retreating back into the hole.
   When hit, a target slowly fades away.
   The components of a target are drawn on top of each other in layers to reduce the amount of required sprites.
   */
  void render() {
    // always render background portion of hole
    imageMode(CENTER);
    image(BonkADoge.images.holeBack, position.x, position.y);

    switch (this.targetState) {
    case ACTIVE:
      // determine offset within spride sheet for movement animation sprite
      // assume by default that target is not in a movement animation
      int spriteOffsetMovement = AMOUNT_SPRITES_MOVEMENT - 1;
      int timeSinceActivation = millis() - timeOfLastActivation;
      if (timeSinceActivation < DURATION_ENTERING) {
        // target is entering
        spriteOffsetMovement = timeSinceActivation / DURATION_FRAME_ENTERING;
      } else if (timeSinceActivation > DURATION_ACTIVE - DURATION_LEAVING) {
        // target is leaving
        spriteOffsetMovement = (DURATION_ACTIVE - timeSinceActivation) / DURATION_FRAME_LEAVING;
      }

      // draw appropriate movement animation sprite from sprite sheet
      PImage spriteMovement = spriteSheetMovement.get(0, SPRITE_HEIGHT * spriteOffsetMovement, SPRITE_WIDTH, SPRITE_HEIGHT);
      image(spriteMovement, position.x, position.y);

      if ((this.timeOfLastActivation + DURATION_ACTIVE) < millis()) {
        // duration of active state ran out, target returns to being inactive
        changeState(TargetState.INACTIVE);
      }
      break;
    case INACTIVE:
      if (this.timeOfNextActivation < millis()) {
        // it is time for target to become active
        changeState(TargetState.ACTIVE);
      }
      break;
    case HIT:
      int timeSinceHit = millis() - timeOfLastHit;
      if (timeSinceHit < DURATION_FADEOUT) {
        // draw fadeout animation
        int spriteOffsetFadeout = timeSinceHit / DURATION_FRAME_FADEOUT;
        PImage spriteFadeout = spriteSheetFadeout.get(0, SPRITE_HEIGHT * spriteOffsetFadeout, SPRITE_WIDTH, SPRITE_HEIGHT);
        image(spriteFadeout, position.x, position.y);

        // draw points received for hit
        hitPoints.render();
      }

      if ((this.timeOfLastHit + DURATION_FADEOUT) < millis()) {
        // duration of hit state has passed, target returns to being inactive
        changeState(TargetState.INACTIVE);
      }
      break;
    }

    // always render foreground portion of hole
    image(BonkADoge.images.holeFront, position.x, position.y);
  }

  /**
   Should only be used during testing to visualize how big the hit area of a target is
   */
  private void drawHitArea() {
    ellipseMode(CENTER);
    noFill();
    stroke(0);
    ellipse(position.x, position.y, TARGET_RADIUS*2, TARGET_RADIUS*2);
  }

  /**
   Always use this method for changing target state due to its side effects,
   except for cases where different/no side effects are desired.
   */
  private void changeState(TargetState newState) {
    switch (newState) {
    case ACTIVE:
      this.timeOfLastActivation = millis();
      break;
    case HIT:
      this.timeOfLastHit = millis();
      break;
    case INACTIVE:
      // prepare for next activation

      // small chance of being negative target
      isNegativeTarget = (int)random(8) == 0;
      // 50% chance to use mirrored sprites
      // this is done to create a bit more variance in target appearance
      boolean spriteIsMirrored = (int)random(2) == 0;

      // determine and cache active sprite sheets once for each activation so that they
      // do no have to be determined repeatedly in the draw loop
      if (isNegativeTarget) {
        if (spriteIsMirrored) {
          spriteSheetMovement = BonkADoge.images.targetNegativeMovementMirrored;
          spriteSheetFadeout = BonkADoge.images.targetNegativeFadeoutMirrored;
        } else {
          spriteSheetMovement = BonkADoge.images.targetNegativeMovement;
          spriteSheetFadeout = BonkADoge.images.targetNegativeFadeout;
        }
      } else {
        if (spriteIsMirrored) {
          spriteSheetMovement = BonkADoge.images.targetPositiveMovementMirrored;
          spriteSheetFadeout = BonkADoge.images.targetPositiveFadeoutMirrored;
        } else {
          spriteSheetMovement = BonkADoge.images.targetPositiveMovement;
          spriteSheetFadeout = BonkADoge.images.targetPositiveFadeout;
        }
      }

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
