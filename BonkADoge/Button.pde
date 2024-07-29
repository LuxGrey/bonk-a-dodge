/**
 An instance of this class represents a button that changes appearance
 when the mouse cursor hovers over it and can detect when it was clicked.
 */
class Button {
  /**
   The position of a button is oriented at its center
   */
  PVector position;
  String buttonText;
  int buttonWidth;
  int buttonHeight;

  Button (PVector position, String buttonText, int buttonWidth, int buttonHeight) {
    this.position = position;
    this.buttonText = buttonText;
    this.buttonWidth = buttonWidth;
    this.buttonHeight = buttonHeight;
  }

  void render() {
    // draw button
    // button changes color in reaction to being hovered over
    if (isHoveredOver(new PVector(mouseX, mouseY))) {
      fill(108, 122, 175);
    } else {
      fill(64, 87, 175);
    }
    rectMode(CENTER);
    rect(position.x, position.y, buttonWidth, buttonHeight);

    // draw button text
    textAlign(CENTER, CENTER);
    textSize(50);
    fill(0);
    text(buttonText, position.x, position.y);
  }

  /**
   Returns true if the mouse cursor, based on mousePosition, is currently hovering over this button.
   Otherwise returns false.
   */
  boolean isHoveredOver(PVector mousePosition) {
    return mousePosition.x >= (position.x - buttonWidth/2 ) // left bound
      && mousePosition.x <= (position.x + buttonWidth/2) // right bound
      && mousePosition.y >= (position.y - buttonHeight/2) // upper bound
      && mousePosition.y <= (position.y + buttonHeight/2); // lower bound
  }
}
