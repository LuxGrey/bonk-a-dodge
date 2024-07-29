/**
 Responsible for rendering and processing logic for the "enter name" screen
 */
class EnterNameHandler {
  private static final int MAX_CHARACTERS_PLAYER_NAME = 10;
  String playerName;
  int playerScore = 0;

  void init(int playerScore) {
    playerName = "";
    this.playerScore = playerScore;
  }

  GameState handleKeyPressed() {
    if (keyCode == BACKSPACE) {
      if (playerName.length() > 0) {
        playerName = playerName.substring(0, playerName.length()-1);
      }
    } else if (keyCode == ENTER || keyCode == RETURN) {
      // signal that the player finished entering their name
      return GameState.SHOWHIGHSCORES;
    } else if (key >= 'a' && key <= 'z' || key >= 'A' && key <= 'Z' || key >= '0' && key <= '9') {
      if (playerName.length() < MAX_CHARACTERS_PLAYER_NAME) {
        playerName += key;
      }
    }

    return GameState.ENTERNAME;
  }

  void render() {
    // TODO use proper background
    background(120, 120, 120);
    textAlign(CENTER, CENTER);
    textSize(50);
    fill(0);
    // add pipe character after name to simulate a text cursor
    text(playerName + "|", width/2, height/2);
  }
}
