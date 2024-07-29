/**
 Responsible for rendering and processing logic for gameplay
 */
class GameplayHandler {
  private static final int AMOUNT_TARGET_ROWS = 3;
  private static final int AMOUNT_TARGET_COLUMNS = 3;
  private static final int DISTANCE_TARGETS_HORIZONTAL = 400;
  private static final int DISTANCE_TARGETS_VERTICAL = 300;
  
  Target[] targets;
  Hud hud;

  GameplayHandler() {
    int amountTargets = AMOUNT_TARGET_ROWS * AMOUNT_TARGET_COLUMNS;
    PVector[] targetPositions = buildTargetPositions();
    targets = new Target[amountTargets];
    for (int i = 0; i < targets.length; ++i) {
      targets[i] = new Target(targetPositions[i]);
    }
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
  
  /**
  Builds an array with the positions of all targets.
  The positions are calculated based on the amount of rows and columns in the grid of targets
  as well as the horizontal and vertical distance between targets.
  The whole grid of targets will be centered in the rendering window.
  */
  PVector[] buildTargetPositions() {
    // calculate x and y coordinates that will be used for target positions

    int[] xCoords = new int[AMOUNT_TARGET_COLUMNS];
    // start with left most position
    int startingXCoord = (width/2) - (DISTANCE_TARGETS_HORIZONTAL * (AMOUNT_TARGET_COLUMNS-1) / 2);
    for (int i = 0; i < xCoords.length; ++i) {
      xCoords[i] = startingXCoord + (DISTANCE_TARGETS_HORIZONTAL * i);
    }
    
    int[] yCoords = new int[AMOUNT_TARGET_ROWS];
    // start with top most position
    int startingYCoord = (height/2) - (DISTANCE_TARGETS_VERTICAL * (AMOUNT_TARGET_ROWS-1) / 2);
    for (int i = 0; i < yCoords.length; ++i) {
      yCoords[i] = startingYCoord + (DISTANCE_TARGETS_VERTICAL * i);
    }

    // build target positions using previously calculated coordinates
    int amountTargets = AMOUNT_TARGET_ROWS * AMOUNT_TARGET_COLUMNS;
    PVector[] targetPositions = new PVector[amountTargets];
    int positionIndex = 0;
    for (int i = 0; i < xCoords.length; ++i) {
      for (int j = 0; j < yCoords.length; ++j) {
        targetPositions[positionIndex] = new PVector(xCoords[i], yCoords[j]);
        ++positionIndex;
      }
    }
    
    return targetPositions;
  }
}
