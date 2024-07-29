/**
 Responsible for rendering and processing logic for the "enter name" screen
 */
class EnterNameHandler {
  private static final int MAX_CHARACTERS_PLAYER_NAME = 10;
  String playerName;
  int playerScore = 0;

  /**
   This method should be called right before switching to the "enter name" state
   to display the correct data from the last gameplay round.
   */
  void init(int playerScore) {
    playerName = "";
    this.playerScore = playerScore;
  }

  /**
   Changes the player name based on key inputs.
   Signals that the process of entering a name is completed by returning a game state
   that differs from the current one.
   */
  GameState handleKeyPressed() {
    if (keyCode == BACKSPACE) {
      // remove last character of name
      if (playerName.length() > 0) {
        playerName = playerName.substring(0, playerName.length()-1);
      }
    } else if (keyCode == ENTER || keyCode == RETURN) {
      // signal that the player finished entering their name
      return GameState.SHOWHIGHSCORES;
    } else if (key >= 'a' && key <= 'z' || key >= 'A' && key <= 'Z' || key >= '0' && key <= '9') {
      // add character to end of name
      if (playerName.length() < MAX_CHARACTERS_PLAYER_NAME) {
        playerName += key;
      }
    }

    return GameState.ENTERNAME;
  }

  /**
   Show a summary of the last gameplay round and display the name
   that the player is currently entering.
   */
  void render() {
    // TODO use proper background
    background(120, 120, 120);

    // draw current player name
    textAlign(CENTER, CENTER);
    textSize(50);
    fill(0);
    // add pipe character after name to simulate a text cursor
    text(playerName + "|", width/2, height/2);
  }
}
