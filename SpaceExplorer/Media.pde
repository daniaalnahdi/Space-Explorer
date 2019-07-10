/**
 Game media, graphics, text formatting, and audio.
 **/

import processing.sound.*;

// text formatting
int headingH;
PFont font;

// images
PImage ship1;
PImage ship2;
PImage healthItem;
PImage emptyLifeItem;
PImage star;

// audio
SoundFile crashed;
SoundFile collected;
SoundFile healed;
SoundFile clicked;
SoundFile denied;
SoundFile typed;
SoundFile background;

// loads all media assets
void loadMedia() {
  headingH = height/4;
  font = createFont("slkscre.ttf", 12);
  backgroundSetup();
  ship1 = loadImage("s1.png");
  ship2 = loadImage("s2.png");
  star = loadImage("star.png");
  healthItem = loadImage("heart.png");
  emptyLifeItem = loadImage("emptyheart.png");
  collected = new SoundFile(this, "collected.wav");
  healed = new SoundFile(this, "healed.wav");
  crashed = new SoundFile(this, "crashed.wav");
  typed = new SoundFile(this, "typed.wav");
  clicked = new SoundFile(this, "clicked.wav");
  denied = new SoundFile(this, "denied.wav");
  background = new SoundFile(this, "background.wav");
  background.amp(0.5);
}

// formats text headings
void formatHeading() {
  textAlign(CENTER);
  textSize(25);
  fill(255);
}
