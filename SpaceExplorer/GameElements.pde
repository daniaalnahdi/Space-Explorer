/**
 Objects representing elements in the game.
 **/

// an abstract class to represent an element in the game
class GameElement {
  int x;
  int y;
  int w;
  int h;
  int d;
  boolean hasEnded;

  GameElement(int xPos, int yPos, int eWidth, int eHeight, int eDur) {
    this.x = xPos;
    this.y = yPos;
    this.w = eWidth;
    this.h = eHeight; 
    this.d = eDur; 
    this.hasEnded = false;
  }

  // returns the x-coordinate
  int xLoc() {
    return this.x;
  }

  // returns the y-coordinate
  int yLoc() {
    return this.y;
  }

  // returns the width
  int getWidth() {
    return this.w;
  }

  // returns the height
  int getHeight() {
    return this.h;
  }

  // checks if the duration of the element has ended
  boolean hasEnded() {
    return this.hasEnded;
  }

  // end the duration of the element
  void endDuration() {
    this.hasEnded = true;
  }
}

// a class for the player represented by a spaceship
class Spaceship extends GameElement {

  Spaceship(int eWidth, int eHeight) {
    super(0, 0, eWidth, eHeight, 0);
  }

  // renders the spaceship
  void drawElement() {


    // set the position of the player to the bottom for the first half second
    if (millis() < gameStartTime + 500) {
      this.x = width/2 - (this.w/2);
      this.y = height - this.h;
    } else {
      // when the above duration has elapsed, position is dependant of the user's mouse location
      this.x = mouseX - (this.w/2);

      // define boundaries for the spaceship
      if (mouseY < 150) {
        this.y = 150;
      } else {
        this.y = mouseY - (this.h/2);
      }
    }

    // render the spaceship based on the player's pick 
    if (pickedS == 1) {
      image(ship1, this.x, this.y);
    } else if (pickedS == 2) {
      image(ship2, this.x, this.y);
    }
  }
}



// a class for a meteor
class Meteor extends GameElement {

  Meteor(int xPos, int eWidth, int dur) {
    super(xPos, 1, eWidth, eWidth, dur);
  }

  // renders the meteor
  void drawElement() {
    strokeWeight(2);

    // draw the meteor at its duration
    if (millis() > this.d) {

      // if there wasn't a collison, render normally
      if (!this.hasEnded) {
        fill(0);
        ellipse(this.x, this.y, this.w, this.h);

        // if there was a collison, render debris
      } else {
        fill(0);
        ellipse(this.x, this.y, this.w*0.2, this.h*0.2);
        ellipse(this.x + 10, this.y - 20, this.w*0.1, this.h*0.1);
        ellipse(this.x - 10, this.y + 20, this.w*0.1, this.h*0.1);
        ellipse(this.x + 10, this.y + 20, this.w*0.1, this.h*0.1);
        ellipse(this.x - 10, this.y - 20, this.w*0.1, this.h*0.1);
        ellipse(this.x + 20, this.y, this.w*0.1, this.h*0.1);
        ellipse(this.x - 20, this.y, this.w*0.1, this.h*0.1);
      }

      // increment its y-value
      this.y += mSpeed;
    } 

    // if the enemy is off the screen
    // the duration has ended
    if (this.y > 700) {
      this.hasEnded = true;
    }
  }
}

// a class for a star
class Star extends GameElement {

  Star(int xPos, int eWidth, int eHeight, int dur) {
    super(xPos, 1, eWidth, eHeight, dur);
  }

  // render the star
  void drawElement() {

    // draw the star during its duration
    if (millis() > this.d) {

      // if the item has yet to be collected
      if (!this.hasEnded) {

        // draw a star
        image(star, this.x, this.y);
        
        // increment the y value
        this.y += 3;
      }
    } 

    // if the collectable is off the screen
    // end its duration
    if (this.y > 700) {
      this.hasEnded = true;
    }
  }
}

// a class to represent a health item
class Health extends GameElement {

  Health(int xPos, int eWidth, int eHeight, int dur) {
    super(xPos, 1, eWidth, eHeight, dur);
  }

  // draw the health item
  void drawElement() { 

    // draw the health item during its duration
    if (millis() > this.d) {

      // if the item has yet to be collected
      if (!this.hasEnded) {
        fill(240, 230, 140);

        // draw a health item
        image(healthItem, this.x, this.y);

        // increment the y value
        this.y += 2;
      }
    } 

    // if the health item is off the screen
    // end its duration
    if (this.y > 700) {
      this.hasEnded = true;
    }
  }
}
