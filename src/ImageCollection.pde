/**
 This class is responsible for loading all images that are used in the program
 and making them available to other classes.
 */
class ImageCollection {
  PImage grassBackground;
  PImage logo;
  PImage targetPositiveMovement;
  PImage targetNegativeMovement;
  PImage targetPositiveFadeout;
  PImage targetNegativeFadeout;
  PImage targetPositiveMovementMirrored;
  PImage targetNegativeMovementMirrored;
  PImage targetPositiveFadeoutMirrored;
  PImage targetNegativeFadeoutMirrored;
  PImage holeBack;
  PImage holeFront;
  PImage exampleTargetPositive;
  PImage exampleTargetNegative;

  ImageCollection() {
    loadImages();
  }

  void loadImages() {
    grassBackground = loadImage("grass_background.png");
    logo = loadImage("logo.png");
    
    targetPositiveMovement = loadImage("spritesheet_cheems_evil_movement.png");
    targetNegativeMovement = loadImage("spritesheet_cheems_normal_movement.png");
    targetPositiveFadeout = loadImage("spritesheet_cheems_evil_fadeout.png");
    targetNegativeFadeout = loadImage("spritesheet_cheems_normal_fadeout.png");
    // load prepared mirrored variants as mirroring images in the program is inconvenient
    targetPositiveMovementMirrored = loadImage("spritesheet_cheems_evil_movement_mirrored.png");
    targetNegativeMovementMirrored = loadImage("spritesheet_cheems_normal_movement_mirrored.png");
    targetPositiveFadeoutMirrored = loadImage("spritesheet_cheems_evil_fadeout_mirrored.png");
    targetNegativeFadeoutMirrored = loadImage("spritesheet_cheems_normal_fadeout_mirrored.png");

    holeBack = loadImage("hole_back.png");
    holeFront = loadImage("hole_front.png");
    exampleTargetPositive = loadImage("example_cheems_evil.png");
    exampleTargetNegative = loadImage("example_cheems_normal.png");
  }
}
