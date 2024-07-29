/**
 Handle audio volume controls and display audio gauge
 */
class VolumeHandler {
  private static final String FILE_NAME_SETTINGS = "settings.csv";
  private static final String COLUMN_NAME_SETTING = "setting";
  private static final String COLUMN_NAME_VALUE = "value";
  private static final String SETTING_NAME_VOLUME = "volume";

  private static final String MESSAGE_VOLUME_UPDATE = "volume";

  private static final int DURATION_GAUGE_DISPLAY = 2000;
  private static final int GAUGE_WIDTH = 400;
  private static final int GAUGE_HEIGHT = 50;
  private static final int MIN_VOLUME = 0;
  private static final int MAX_VOLUME = 120;
  private static final int DEFAULT_VOLUME = 100;
  private static final int VOLUME_INCREMENT = 10;

  /**
   Used to persist volume settings in a file
   */
  Table settings;
  int timeOfLastVolumeChange;

  VolumeHandler() {
    // initalize with value in the past so that gauge is not displayed
    timeOfLastVolumeChange = millis() - DURATION_GAUGE_DISPLAY;
    loadVolumeSettings();
  }

  /**
   Display gauge with current volume for a certain duration after attempting to change volume
   */
  void render() {
    if (millis() < timeOfLastVolumeChange + DURATION_GAUGE_DISPLAY) {
      rectMode(CORNER);
      int gaugeStartX = width/2 - GAUGE_WIDTH/2;
      int gaugeStartY = height - 100;

      // draw gauge container
      fill(30, 30, 30);
      rect(gaugeStartX, gaugeStartY, GAUGE_WIDTH, GAUGE_HEIGHT);

      // draw gauge bar
      fill(64, 87, 175);
      int currentVolume = getVolume();
      int currentWidth = (int)(GAUGE_WIDTH * ((float)currentVolume / MAX_VOLUME));
      rect(gaugeStartX, gaugeStartY, currentWidth, GAUGE_HEIGHT);

      // draw info text
      // left pad volume in info string
      String infoText = String.format("Volume: %1$3s", currentVolume);
      textAlign(CENTER, CENTER);
      textSize(40);
      fill(200);
      text(infoText, width/2, gaugeStartY + (GAUGE_HEIGHT/2));
    }
  }

  /**
   Allow changing volume via key inputs
   */
  void handleKeyPressed() {
    boolean volumeWasChanged = false;
    int currentVolume = getVolume();

    if (keyCode == UP) {
      // increase volume
      if (currentVolume < MAX_VOLUME) {
        setVolume(currentVolume + VOLUME_INCREMENT);
      }
      volumeWasChanged = true;
    } else if (keyCode == DOWN) {
      // decrease volume
      if (currentVolume > MIN_VOLUME) {
        setVolume(currentVolume - VOLUME_INCREMENT);
      }
      volumeWasChanged = true;
    }

    if (volumeWasChanged) {
      timeOfLastVolumeChange = millis();
      sendUpdateVolumeMessage();
      saveVolumeSettings();
    }
  }

  void sendUpdateVolumeMessage() {
    OscMessage message = new OscMessage(MESSAGE_VOLUME_UPDATE);
    message.add(getVolume());
    BonkADoge.sendOscMessage(message);
  }

  void loadVolumeSettings() {
    settings = loadTable(FILE_NAME_SETTINGS, "header");
    if (settings == null) {
      // file was not found, initialize new settings table
      println("Initializing new settings table");
      settings = new Table();
      settings.addColumn(COLUMN_NAME_SETTING);
      settings.addColumn(COLUMN_NAME_VALUE);
      settings.setColumnType(COLUMN_NAME_VALUE, Table.INT);

      // add default setting for volume
      TableRow row = settings.addRow();
      row.setString(COLUMN_NAME_SETTING, SETTING_NAME_VOLUME);
      row.setInt(COLUMN_NAME_VALUE, DEFAULT_VOLUME);
    } else {
      settings.setColumnType(COLUMN_NAME_VALUE, Table.INT);
    }
  }

  void saveVolumeSettings() {
    saveTable(settings, "data/" + FILE_NAME_SETTINGS);
  }

  private int getVolume() {
    return getVolumeSettingsRow().getInt(COLUMN_NAME_VALUE);
  }

  private void setVolume(int volume) {
    getVolumeSettingsRow().setInt(COLUMN_NAME_VALUE, volume);
  }

  private TableRow getVolumeSettingsRow() {
    return settings.findRow(SETTING_NAME_VOLUME, COLUMN_NAME_SETTING);
  }
}
