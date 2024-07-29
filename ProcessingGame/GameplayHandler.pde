/**
 Responsible for rendering and processing logic for gameplay
 */
class GameplayHandler {
  static final int amountTargets = 9;
  static final int maxAmountActiveTargets = 5;
  // the minimal amount of time that has to pass between target activations
  static final int delayTargetActivation = 500;

  Target[] targets;
  Hud hud;
  int amountActiveTargets;
  // the timestamp at which the target last became active
  int timeLastTargetActivation;

  GameplayHandler() {
    targets = new Target[amountTargets];
    targets[0] = new Target(new PVector(450, 200));
    targets[1] = new Target(new PVector(750, 200));
    targets[2] = new Target(new PVector(1050, 200));
    targets[3] = new Target(new PVector(450, 500));
    targets[4] = new Target(new PVector(750, 500));
    targets[5] = new Target(new PVector(1050, 500));
    targets[6] = new Target(new PVector(450, 800));
    targets[7] = new Target(new PVector(750, 800));
    targets[8] = new Target(new PVector(1050, 800));
    hud = new Hud();
  }

  /**
   This method should be called right before every every gameplay round to
   reset this instance to its initial state.
   */
  void init() {
    timeLastTargetActivation = millis();
    amountActiveTargets = 0;

    for (Target target : targets) {
      target.init();
    }
    hud.init();
  }

  /**
   Renders the gameplay, including targets and HUD.
   Returns an appropriate GameState when the time for the gameplay round has run out, otherwise returns the current
   gameplay state.
   */
  GameState render() {
    // draw background
    // TODO draw proper background
    background(120, 120, 120);

    // attempt to activate target
    if (
      amountActiveTargets < maxAmountActiveTargets
      && (timeLastTargetActivation + delayTargetActivation) < millis()
      ) {
      int index = (int)random(targets.length);
      if (targets[index].targetState == TargetState.INACTIVE) {
        targets[index].switchState(TargetState.ACTIVE);
        timeLastTargetActivation = millis();
      }
    }

    // draw targets
    int activeTargetsCounter = 0;
    for (Target target : targets) {
      target.render();
      if (target.targetState == TargetState.ACTIVE) {
        activeTargetsCounter++;
      }
    }
    amountActiveTargets = activeTargetsCounter;

    // draw HUD
    hud.render();

    if (hud.countdown <= 0) {
      return GameState.GAMEOVER;
    }

    return GameState.GAMEPLAY;
  }

  void handleMousePressed() {
    PVector mouseVector = new PVector(mouseX, mouseY);
    for (Target target : targets) {
      if (target.checkHit(mouseVector)) {
        amountActiveTargets--;
        this.hud.score += target.points;

        // skip checking remaining targets
        break;
      }
    }
  }
}
