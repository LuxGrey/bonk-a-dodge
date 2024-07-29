class HighscoresHandler {
  private static final String FILE_NAME_HIGHSCORES = "highscores.csv";
  private static final String COLUMN_NAME_SCORE = "score";
  private static final String COLUMN_NAME_PLAYER_NAME = "playerName";
  private static final int MAX_AMOUNT_HIGHSCORES = 10;

  Table highscores;

  void render() {
    // TODO use proper background
    background(120, 120, 120);

    textSize(30);
    for (int i = 0; i < highscores.getRowCount(); i++) {
      String playerName = highscores.getRow(i).getString(COLUMN_NAME_PLAYER_NAME);
      int score = highscores.getRow(i).getInt(COLUMN_NAME_SCORE);
      text(playerName + ":" + score, 200, 100+50*i);
    }
  }

  /**
   Loads the highscores table from a file or creates a blank table if the file could not be found
   */
  void loadHighscores() {
    highscores = loadTable(FILE_NAME_HIGHSCORES, "header");
    if (highscores == null) {
      // file was not found, initialize new highscores table
      println("Initializing new highscores table");
      highscores =  new Table();
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
    while (highscores.getRowCount() > MAX_AMOUNT_HIGHSCORES) {
      highscores.removeRow(highscores.getRowCount()-1);
    }
    // for unknown reasons loadTable() assumes the data directory while saveTable() does not
    saveTable(highscores, "data/" + FILE_NAME_HIGHSCORES);
  }
}
