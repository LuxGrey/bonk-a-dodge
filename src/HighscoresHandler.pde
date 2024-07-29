/**
 Responsible for displaying player highscores as well as reading them from and writing them to a file.
 */
class HighscoresHandler {
  private static final String FILE_NAME_HIGHSCORES = "highscores.csv";
  private static final String COLUMN_NAME_SCORE = "score";
  private static final String COLUMN_NAME_PLAYER_NAME = "playerName";
  private static final int MAX_AMOUNT_HIGHSCORES = 10;

  Table highscores;

  /**
   Display highscores of best players in order.
   */
  void render() {
    background(BonkADoge.images.grassBackground);
    drawTextBox();
    drawTitle();
    drawScores();
    drawReturnHint();
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
    fill(291, 199, 42);
    textSize(70);
    textAlign(CENTER, CENTER);
    text("Highscores", width/2, 100);
  }

  private void drawScores() {
    fill(200);
    textSize(40);
    for (int i = 0; i < highscores.getRowCount(); i++) {
      String playerName = highscores.getRow(i).getString(COLUMN_NAME_PLAYER_NAME);
      int score = highscores.getRow(i).getInt(COLUMN_NAME_SCORE);

      // left-aligned player name
      textAlign(LEFT, CENTER);
      text(playerName, 400, 200 + (i*70));

      // right-aligned score
      textAlign(RIGHT, CENTER);
      text(score, width-400, 200 + (i*70));
    }
  }

  private void drawReturnHint() {
    fill(255);
    textSize(40);
    textAlign(CENTER, CENTER);
    text("Press any key to return to main menu", width/2, height-80);
  }

  /**
   Loads the highscores table from a file or creates a blank table if the file could not be found
   */
  void loadHighscores() {
    highscores = loadTable(FILE_NAME_HIGHSCORES, "header");
    if (highscores == null) {
      // file was not found, initialize new highscores table
      println("Initializing new highscores table");
      highscores = new Table();
      highscores.addColumn(COLUMN_NAME_PLAYER_NAME);
      highscores.addColumn(COLUMN_NAME_SCORE);
    }

    highscores.setColumnType(COLUMN_NAME_SCORE, Table.INT);
  }

  /**
   Accepts a player name and score, adds them as a new row to the loaded highscores table
   and writes the <MAX_AMOUNT_HIGHSCORES> best scores back to the highscores file in descending order
   */
  void writeHighscore(String playerName, int score) {
    TableRow row = highscores.addRow();
    row.setString(COLUMN_NAME_PLAYER_NAME, playerName);
    row.setInt(COLUMN_NAME_SCORE, score);
    highscores.sortReverse(COLUMN_NAME_SCORE);
    // remove highscores that number beyond max amount
    while (highscores.getRowCount() > MAX_AMOUNT_HIGHSCORES) {
      highscores.removeRow(highscores.getRowCount()-1);
    }
    // for unknown reasons loadTable() assumes the data directory while saveTable() does not
    saveTable(highscores, "data/" + FILE_NAME_HIGHSCORES);
  }
}
