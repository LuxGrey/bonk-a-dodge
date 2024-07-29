/**
 Responsible for rendering and processing logic for the main menu
 */
class MainMenuHandler {
  Button startGameplayButton;
  Button showHighscoresButton;

  MainMenuHandler() {
    startGameplayButton = new Button(
      new PVector(width/2, 400),
      "Start bonking",
      500,
      70
    );

    showHighscoresButton = new Button(
      new PVector(width/2, 600),
      "Show highscores",
      500,
      70
    );
  }

  /**
   Draws main menu with interactive buttons
   */
  void render() {
    // TODO draw proper background
    background(120, 120, 120);

    startGameplayButton.render();
    showHighscoresButton.render();
  }

  /**
   Checks if a button was pressed and return the appropriate new game state
   */
  GameState handleMousePressed() {
    PVector mousePosition =  new PVector(mouseX, mouseY);
    if (startGameplayButton.isHoveredOver(mousePosition)) {
      return GameState.GAMEPLAY;
    } else if (showHighscoresButton.isHoveredOver(mousePosition)) {
      return GameState.SHOWHIGHSCORES;
    }

    // remain in current game state
    return GameState.MAINMENU;
  }
}
