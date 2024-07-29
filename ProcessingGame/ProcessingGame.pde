enum GameState {
  GAMEPLAY,
  GAMEOVER
}

/**
Stores the current state of the game in terms of which elements should be drawn and what the current options for interaction are
*/
GameState gameState;
Hole[] holes;
Hud hud;

void setup() {
  size(1500, 1000);
  // TODO initialize program with proper state
  gameState = GameState.GAMEPLAY;
  holes = new Hole[9];
  holes[0] = new Hole(new PVector(450, 200));
  holes[1] = new Hole(new PVector(750, 200));
  holes[2] = new Hole(new PVector(1050, 200));
  holes[3] = new Hole(new PVector(450, 500));
  holes[4] = new Hole(new PVector(750, 500));
  holes[5] = new Hole(new PVector(1050, 500));
  holes[6] = new Hole(new PVector(450, 800));
  holes[7] = new Hole(new PVector(750, 800));
  holes[8] = new Hole(new PVector(1050, 800));
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

void drawGameplay() {
  // draw background
  // TODO draw proper background
  background(120, 120, 120);
  
  // draw holes
  for (Hole hole : holes) {
    hole.render();
  }
  
  // draw HUD
  hud.render();
}

void drawGameOver() {
}

void handleMousePressedGameplay() {
  PVector mouseVector = new PVector(mouseX, mouseY);
  for (Hole hole : holes) {
    if (hole.checkHit(mouseVector)) {
      this.hud.score += hole.points;
      
      // skip checking remaining holes
      break;
    }
  }
}
