/**
 Code for rendering the animated starry background.
 **/

// variables for drawing the stars
ArrayList<TwinklingStar> twinklingStars = new ArrayList();
int starsCount = 35;
int endTwinkle = 500;
// selected stars to be animated
TwinklingStar rand1;
TwinklingStar rand2;
TwinklingStar rand3;
TwinklingStar rand4;

// class representing a single star
class TwinklingStar {
  int x;
  int y;
  int r;

  TwinklingStar(int xPos, int yPos, int radius) {
    this.x = xPos;
    this.y = yPos;
    this.r = radius;
  }

  // returns the x-coordinate of the star
  int getX() {
    return this.x;
  }

  // returns the y-coordinate of the star
  int getY() {
    return this.y;
  }

  // returns the radius of the star
  int getRadius() {
    return this.r;
  }

  // renders the star
  void drawStar() {
    noStroke();
    PShape star = createShape(ELLIPSE, x, y, r, r);
    shape(star);
  }

  // renders the star as it shines
  void twinkle() {
    stroke(255);
    strokeWeight(1); 

    line(this.x, this.y, this.x, this.y + this.r*2); 
    line(this.x, this.y, this.x, this.y - this.r*2); 
    line(this.x, this.y, this.x - this.r*2, this.y); 
    line(this.x, this.y, this.x + this.r*2, y);
  }
}


// sets up the variables for rendering the background
void backgroundSetup() {

  int x;
  int y;
  int s;

  // randomly generate the stars 
  for (int i=0; i <= starsCount; i++) {

    x = (int) random(1, width);
    y = (int) random(1, height);
    s = (int) random(1, 4);

    twinklingStars.add(new TwinklingStar(x, y, s));
  }

  // select random stars to be animated
  rand1 = twinklingStars.get((int)random(0, starsCount));
  rand2 = twinklingStars.get((int)random(0, starsCount));
  rand3 = twinklingStars.get((int)random(0, starsCount));
  rand4 = twinklingStars.get((int)random(0, starsCount));
}

// render the background
void drawBackground() {
  background(0);
  fill(255);

  for (TwinklingStar star : twinklingStars) {
    star.drawStar();
  }

  twinkle();
}

// animates four random stars every 500 milliseconds
void twinkle() {

  if (millis() < endTwinkle) {

    rand1.twinkle();
    rand2.twinkle();
    rand3.twinkle();
    rand4.twinkle();
    
  } else {

    rand1 = twinklingStars.get((int)random(0, starsCount));
    rand2 = twinklingStars.get((int)random(0, starsCount));
    rand3 = twinklingStars.get((int)random(0, starsCount));
    rand4 = twinklingStars.get((int)random(0, starsCount));

    rand1.twinkle();
    rand2.twinkle();
    rand3.twinkle();
    rand4.twinkle();

    endTwinkle += 500;
  }
}
