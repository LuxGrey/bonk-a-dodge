/**
Instances of this class are used to draw the HUD during gameplay,
which includes the current player score and remaining time.
*/
class Hud {
  int timer;
  int score;
  
  Hud() {
    timer = 0;
    score = 0;
  }
  
  void render() {
    // render current score in upper right corner
    textSize(50);
    textAlign(RIGHT, TOP);
    fill(0);
    text(score, width-10, 10);
  }
}
