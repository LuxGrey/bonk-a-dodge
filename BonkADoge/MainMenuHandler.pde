/**
 Responsible for rendering and processing logic for the main menu
 */
class MainMenuHandler {
  Button startGameplayButton;
  Button showHighscoresButton;
  Button showHowToPlayButton;
  Button exitButton;

  MainMenuHandler() {
    startGameplayButton = new Button(
      new PVector(width/2, 400),
      "Start bonking",
      500,
      70
    );
    
    showHowToPlayButton = new Button(
      new PVector(width/2, 550),
      "How to play",
      500,
      70
    );
    
    showHighscoresButton = new Button(
      new PVector(width/2, 700),
      "Show highscores",
      500,
      70
    );
    
    exitButton = new Button(
      new PVector(width/2, 850),
      "Exit",
      500,
      70
    );
  }

  /**
   Draws main menu with interactive buttons
   */
  void render() {
    background(BonkADoge.images.grassBackground);

    startGameplayButton.render();
    showHowToPlayButton.render();
        showHighscoresButton.render();
    exitButton.render();
  }

  /**
   Checks if a button was pressed and return the appropriate new game state
   */
  GameState handleMousePressed() {
    PVector mousePosition =  new PVector(mouseX, mouseY);
    if (startGameplayButton.isHoveredOver(mousePosition)) {
      return GameState.GAMEPLAY;
    } else if (showHowToPlayButton.isHoveredOver(mousePosition)) {
      return GameState.HOWTOPLAY;
    } else if (showHighscoresButton.isHoveredOver(mousePosition)) {
      return GameState.SHOWHIGHSCORES;
    } else if (exitButton.isHoveredOver(mousePosition)) {
      return GameState.EXITGAME;
    }

    // remain in current game state
    return GameState.MAINMENU;
  }
}
