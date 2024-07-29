/**
 Stores the current state of the game in terms of which elements should be drawn and what the current options for interaction are
 */
GameState gameState;
MainMenuHandler mainMenuHandler;
GameplayHandler gameplayHandler;

void setup() {
  size(1500, 1000);
  frameRate = 60;

  // create handlers for different game states
  mainMenuHandler = new MainMenuHandler();
  gameplayHandler = new GameplayHandler();

  // start the game in the main menu
  gameState = GameState.MAINMENU;
}

void draw() {
  // TODO properly implement other cases
  switch(gameState) {
  case MAINMENU:
    mainMenuHandler.render();
    break;
  case GAMEPLAY:
    drawGameplay();
    break;
  case GAMEOVER:
    // TODO properly implement game over draw mode
    background(255);
    break;
  default:
    // TODO remove this case, all cases should be explicitly handled
    break;
  }
}

/**
 Draw gameplay and execute gameplay logic.
 Switch to the game over screen when a gameplay round is over.
 */
void drawGameplay() {
  GameState requestedState = gameplayHandler.render();
  switch (requestedState) {
  case GAMEOVER:
    gameState = GameState.GAMEOVER;
    break;
  default:
    // do nothing
    break;
  }
}

void mousePressed() {
  // TODO properly implement other cases
  switch(gameState) {
  case GAMEPLAY:
    gameplayHandler.handleMousePressed();
    break;
  case MAINMENU:
    handleMousePressedMainMenu();
    break;
  default:
    // do nothing
    break;
  }
}

void handleMousePressedMainMenu() {
  // clicking buttons in the main menu causes game state changes
  GameState requestedState = mainMenuHandler.handleMousePressed();
  switch(requestedState) {
  case GAMEPLAY:
    gameplayHandler.init();
    gameState = GameState.GAMEPLAY;
    break;
  default:
    // do nothing
    break;
  }
}

void keyPressed() {
  // TODO implement proper key press handling
  switch(gameState) {
     case GAMEOVER:
       gameState = GameState.MAINMENU;
       break;
     default:
       // do nothing
       break;
  }
}
