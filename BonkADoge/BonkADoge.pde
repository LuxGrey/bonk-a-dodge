import oscP5.*;
import netP5.*;

private static final String MESSAGE_BGM_DEFAULT = "bgmDefault";
private static final String MESSAGE_BGM_GAMEPLAY = "bgmGameplay";

/**
 Allows global access to all required images
 */
static ImageCollection images;
private static OscP5 osc;
private static NetAddress oscRecipientAddress;

/**
 Stores the current state of the game in terms of what should be drawn, what the current options for interaction are and what logic should be run
 */
GameState gameState;

MainMenuHandler mainMenuHandler;
GameplayHandler gameplayHandler;
EnterNameHandler enterNameHandler;
HighscoresHandler highscoresHandler;

/**
 Provide function for sending OSC messages that can be accessed globally
*/
static void sendOscMessage(OscMessage message) {
  osc.send(message, oscRecipientAddress);
}

void setup() {
  size(1500, 1000);
  frameRate = 60;

  // create image collection and load images
  images = new ImageCollection();
  
  // initialize sound control
  osc = new OscP5(this, 12000);
  oscRecipientAddress = new NetAddress("127.0.0.1", 12345);

  // create handlers for different game states
  mainMenuHandler = new MainMenuHandler();
  gameplayHandler = new GameplayHandler();
  enterNameHandler = new EnterNameHandler();
  highscoresHandler = new HighscoresHandler();

  highscoresHandler.loadHighscores();

  // start the game in the main menu
  gameState = GameState.MAINMENU;
  
  // start default background music
  sendOscMessage(new OscMessage(MESSAGE_BGM_DEFAULT));
}

void draw() {
  switch(gameState) {
  case MAINMENU:
    mainMenuHandler.render();
    break;
  case GAMEPLAY:
    drawGameplay();
    break;
  case ENTERNAME:
    enterNameHandler.render();
    break;
  case SHOWHIGHSCORES:
    highscoresHandler.render();
    break;
  }
}

/**
 Draw the gameplay screen and execute gameplay logic.
 Switch to the "enter name" screen when a gameplay round is over.
 */
private void drawGameplay() {
  GameState requestedState = gameplayHandler.render();
  switch (requestedState) {
  case ENTERNAME:
    // gameplay round has ended, return to playing default background music
    sendOscMessage(new OscMessage(MESSAGE_BGM_DEFAULT));
    enterNameHandler.init(gameplayHandler.hud.score);
    gameState = GameState.ENTERNAME;
    break;
  default:
    // do nothing
    break;
  }
}

void mousePressed() {
  switch(gameState) {
  case GAMEPLAY:
    gameplayHandler.handleMousePressed();
    break;
  case MAINMENU:
    mousePressedMainMenu();
    break;
  case SHOWHIGHSCORES:
    gameState = GameState.MAINMENU;
  default:
    // do nothing
    break;
  }
}

/**
 Handles mouse clicks in the main menu screen.
 Clicking buttons in that screen can cause game state changes.
 */
private void mousePressedMainMenu() {
  GameState requestedState = mainMenuHandler.handleMousePressed();
  switch(requestedState) {
  case GAMEPLAY:
    // start gameplay background music
    sendOscMessage(new OscMessage(MESSAGE_BGM_GAMEPLAY));
    gameplayHandler.init();
    gameState = GameState.GAMEPLAY;
    break;
  case SHOWHIGHSCORES:
    // return to the main menu upon clicking anywhere
    gameState = GameState.SHOWHIGHSCORES;
    break;
  default:
    // do nothing
    break;
  }
}

void keyPressed() {
  switch(gameState) {
  case ENTERNAME:
    keyPressedEnterName();
    break;
  case SHOWHIGHSCORES:
    // return to the main menu upon pressing any key
    gameState = GameState.MAINMENU;
    break;
  default:
    // do nothing
    break;
  }
}

/**
 Delegate to EnterNameHandler for handling key presses and proceed to next game state
 when player name was entered.
 */
private void keyPressedEnterName() {
  GameState requestedState = enterNameHandler.handleKeyPressed();
  switch(requestedState) {
  case SHOWHIGHSCORES:
    highscoresHandler.writeHighscore(enterNameHandler.playerName, gameplayHandler.hud.score);
    gameState = GameState.SHOWHIGHSCORES;
    break;
  default:
    // do nothing
    break;
  }
}
