/**
 This class is responsible for loading all images that are used in the program
 and making them available to other classes.
 */
class ImageCollection {
  PImage grassBackground;
  PImage targetPositiveMovement;
  PImage targetNegativeMovement;
  PImage targetPositiveFadeout;
  PImage targetNegativeFadeout;
  PImage holeBack;
  PImage holeFront;

  ImageCollection() {
    loadImages();
  }

  void loadImages() {
    grassBackground = loadImage("grass_background.png");
    targetPositiveMovement = loadImage("spritesheet_cheems_evil_movement.png");
    targetNegativeMovement = loadImage("spritesheet_cheems_normal_movement.png");
    targetPositiveFadeout = loadImage("spritesheet_cheems_evil_fadeout.png");
    targetNegativeFadeout = loadImage("spritesheet_cheems_normal_fadeout.png");
    holeBack = loadImage("hole_back.png");
    holeFront = loadImage("hole_front.png");
  }
}