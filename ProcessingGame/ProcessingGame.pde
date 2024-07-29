final int amountTargets = 9;
final int maxAmountActiveTargets = 5;
// the minimal amount of time that has to pass between target activations
final int delayTargetActivation = 500;
/**
Stores the current state of the game in terms of which elements should be drawn and what the current options for interaction are
*/
GameState gameState;
Target[] targets;
int amountActiveTargets;
// the timestamp at which the target last became active
int timeLastTargetActivation;
Hud hud;

void setup() {
  size(1500, 1000);
  frameRate = 60;
  
  // TODO initialize program with proper state
  gameState = GameState.GAMEPLAY;

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
  timeLastTargetActivation = millis();
  amountActiveTargets = 0;

  hud = new Hud();
}

void draw() {
  switch(gameState) {
    case GAMEPLAY:
      drawGameplay();
    break;
    case GAMEOVER:
      drawGameOver();
    break;
  }
}

void drawGameplay() {
  // draw background
  // TODO draw proper background
  background(120, 120, 120);
  
  // attempt to activate target
  if (
    amountActiveTargets < maxAmountActiveTargets
    && (timeLastTargetActivation + delayTargetActivation) < millis()
  ) {
    int index = (int)random(targets.length);
    println("Attempting to activate target " + index + " at " + millis());
    if (targets[index].targetState == TargetState.INACTIVE) {
      targets[index].switchState(TargetState.ACTIVE);
      timeLastTargetActivation = millis();
      println("Target activated");
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
}

void drawGameOver() {
}

void mousePressed() {
  switch(gameState) {
    case GAMEPLAY:
      handleMousePressedGameplay();
    break;
    default:
      // TODO properly implement other cases
      // do nothing
    break;
  }
}

void handleMousePressedGameplay() {
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
