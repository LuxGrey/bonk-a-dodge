/**
 Handle audio volume controls and display audio gauge
 */
class VolumeHandler {
  private static final String MESSAGE_VOLUME_UPDATE = "volume";

  private static final int DURATION_GAUGE_DISPLAY = 2000;
  private static final int GAUGE_WIDTH = 400;
  private static final int GAUGE_HEIGHT = 50;
  private static final int MIN_VOLUME = 0;
  private static final int MAX_VOLUME = 120;
  private static final int VOLUME_INCREMENT = 10;

  int timeOfLastVolumeChange;
  int volume;

  VolumeHandler() {
    // initalize with value in the past so that gauge is not displayed
    timeOfLastVolumeChange = millis() - DURATION_GAUGE_DISPLAY;
    volume = 100;
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
      int currentWidth = (int)(GAUGE_WIDTH * ((float)volume / MAX_VOLUME));
      rect(gaugeStartX, gaugeStartY, currentWidth, GAUGE_HEIGHT);

      // draw info text
      // left pad volume in info string
      String infoText = String.format("Volume: %1$3s", volume);
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

    if (keyCode == UP) {
      // increase volume
      if (volume < MAX_VOLUME) {
        volume += VOLUME_INCREMENT;
      }
      volumeWasChanged = true;
    } else if (keyCode == DOWN) {
      // decrease volume
      if (volume > MIN_VOLUME) {
        volume -= VOLUME_INCREMENT;
      }
      volumeWasChanged = true;
    }

    if (volumeWasChanged) {
      timeOfLastVolumeChange = millis();
      sendUpdateVolumeMessage();
    }
  }

  void sendUpdateVolumeMessage() {
    OscMessage message = new OscMessage(MESSAGE_VOLUME_UPDATE);
    message.add(volume);
    BonkADoge.sendOscMessage(message);
  }
}
