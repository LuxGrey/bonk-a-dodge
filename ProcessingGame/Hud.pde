/**
 Instances of this class are used to draw the HUD during gameplay,
 which includes the current player score and remaining time.
 */
class Hud {
  static final int COUNTDOWN_START_VALUE = 59;

  int countdown;
  int score;
  int timeOfLastTick;

  /**
   This method should be called right before every every gameplay round to
   reset this instance to its initial state.
   */
  void init() {
    countdown = COUNTDOWN_START_VALUE;
    score = 0;
    timeOfLastTick = millis();
  }

  void render() {
    updateCountdown();
    renderScore();
    renderCountdown();
  }

  /**
   Render current score in upper right corner
   */
  void renderScore() {
    textSize(50);
    textAlign(RIGHT, TOP);
    fill(0);
    text(score, width-10, 10);
  }

  /**
   Render countdown in the upper left corner
   */
  void renderCountdown() {
    textSize(50);
    textAlign(LEFT, TOP);
    fill(0);
    text(countdown, 10, 10);
  }

  /**
   Decrements countdown each second until it reaches 0
   */
  void updateCountdown() {
    if (millis() >= timeOfLastTick + 1000 && countdown > 0) {
      // one second interval has passed, update countdown
      timeOfLastTick = millis();
      countdown--;
    }
  }
}
