/**
 Responsible for rendering and processing logic for the "how to play" screen
 */
class HowToPlayHandler {
  /**
   Draws how to play guide with explanatory text and images
   */
  void render () {
    background(BonkADoge.images.grassBackground);
    
    drawTextBox();
    drawTitle();
    drawExplanation();
    drawReturnHint();
  }

  /**Draws a dark transparent text box to provide a background for the text that will allow
   for better contrast
   */
  private void drawTextBox() {
    fill(0, 170);
    rectMode(CENTER);
    rect(width/2, height/2, width*0.7, height*0.95);
  }

  private void drawTitle() {
    fill(291, 199, 42);
    textSize(70);
    textAlign(CENTER, CENTER);
    text("How to play", width/2, 100);
  }
  
  private void drawExplanation() {
    textSize(30);
    textAlign(LEFT, CENTER);
    rectMode(CENTER);
    
    // draw game principles explanation
    int textAreaWidth = int(width*0.65);
    fill(200);
    text("Try to earn as many points as possible before the timer runs out.", width/2, 200, textAreaWidth, 50);
    text("Points are earned by hitting (clicking on) evil doges.", width/2, 250, textAreaWidth, 50);
    text("Avoid hitting innocent doges, as hitting them will deduct points.", width/2, 300, textAreaWidth, 50);
    
    // draw target explanations
    imageMode(CENTER);
    textAlign(CENTER, CENTER);
    int leftColumnPosX = (width/2) - (textAreaWidth/4);
    image(BonkADoge.images.exampleTargetPositive, leftColumnPosX, 480);
    text("An evil doge possessed by a demon", leftColumnPosX, 600);
    text("Strike on sight", leftColumnPosX, 650);

    int rightColumnPosX = (width/2) + (textAreaWidth/4);
    image(BonkADoge.images.exampleTargetNegative, rightColumnPosX, 480);
    text("An innocent doge, goodest of boys", rightColumnPosX, 600);
    text("Must not harm", rightColumnPosX, 650);
    
    // draw volume controls explanation
    textAlign(LEFT, CENTER);
    text("By the way, you can adjust the volume at any time using the [UP] and [DOWN] arrow keys.", width/2, 800, textAreaWidth, 100);
  }

  private void drawReturnHint() {
    fill(255);
    textSize(40);
    textAlign(CENTER, CENTER);
    text("Press any key to return to main menu", width/2, height-80);
  }
}
