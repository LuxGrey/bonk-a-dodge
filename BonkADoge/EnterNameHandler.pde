/**
 Responsible for rendering and processing logic for the "enter name" screen
 */
class EnterNameHandler {
  private static final int MAX_CHARACTERS_PLAYER_NAME = 20;
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
    background(BonkADoge.images.grassBackground);
    drawTextBox();
    drawTitle();
    drawSummaryAndPlayerName();
  }

  /**
   Draws a dark transparent text box to provide a background for the text that will allow
   for better contrast
   */
  private void drawTextBox() {
    fill(0, 170);
    rectMode(CENTER);
    rect(width/2, height/2, width*0.6, height*0.95);
  }

  private void drawTitle() {
    fill(255);
    textSize(70);
    textAlign(CENTER, CENTER);
    text("The round is over!", width/2, 100);
  }

  private void drawSummaryAndPlayerName() {
    textAlign(CENTER, CENTER);
    textSize(50);

    // draw summary
    fill(255);
    text("Your score:", width/2, 300);
    fill(291, 199, 42);
    textSize(70);
    text("" + playerScore, width/2, 400);

    // draw player name
    fill(255);
    textSize(50);
    text("Please enter your name", width/2, 600);
    text("( finish by pressing [ENTER] )", width/2, 650);

    fill(200);
    // add pipe character after name to simulate a text cursor
    text(playerName + "|", width/2, 750);
  }
}
