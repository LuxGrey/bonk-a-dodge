/**
 This class is responsible for loading all images that are used in the program
 and making them available to other classes.
 */
class ImageCollection {
  PImage targetPositive;
  PImage targetNegative;
  PImage positiveFadeout;
  PImage negativeFadeout;
  PImage holeBack;
  PImage holeFront;

  ImageCollection() {
    loadImages();
  }

  void loadImages() {
    targetPositive = loadImage("spritesheet_cheems_evil_movement.png");
    targetNegative = loadImage("spritesheet_cheems_normal_movement.png");
    positiveFadeout = loadImage("spritesheet_cheems_evil_fadeout.png");
    negativeFadeout = loadImage("spritesheet_cheems_normal_fadeout.png");
    holeBack = loadImage("hole_back.png");
    holeFront = loadImage("hole_front.png");
  }
}
