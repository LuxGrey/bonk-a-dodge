/**
 Responsible for rendering and processing logic for gameplay
 */
class GameplayHandler {
  private static final int AMOUNT_TARGETS = 9;

  Target[] targets;
  Hud hud;

  GameplayHandler() {
    targets = new Target[AMOUNT_TARGETS];
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

    // draw targets
    for (Target target : targets) {
      target.render();
    }

    // draw HUD
    hud.render();

    if (hud.countdown <= 0) {
      return GameState.ENTERNAME;
    }

    return GameState.GAMEPLAY;
  }

  void handleMousePressed() {
    PVector mouseVector = new PVector(mouseX, mouseY);
    for (Target target : targets) {
      if (target.checkHit(mouseVector)) {
        this.hud.score += target.getPointsForHit();

        // skip checking remaining targets
        break;
      }
    }
  }
}
