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

  void render() {
    // draw background
    // TODO draw proper background
    background(120, 120, 120);

    startGameplayButton.render();
    showHighscoresButton.render();
  }

  /**
   In the main menu, a mouse press can cause a game state change when a button is clicked.
   As such, the method returns the new game state after a mouse press.
   If no button was clicked, returns the current game state.
   */
  GameState handleMousePressed() {
    PVector mousePosition =  new PVector(mouseX, mouseY);
    if (startGameplayButton.isHoveredOver(mousePosition)) {
      return GameState.GAMEPLAY;
    } else if (showHighscoresButton.isHoveredOver(mousePosition)) {
      return GameState.SHOWHIGHSCORES;
    }

    return GameState.MAINMENU;
  }
}
