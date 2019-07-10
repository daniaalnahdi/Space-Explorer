// renders all of the game elements
void drawGameElements() {

  for (Meteor m : meteors) {
    m.drawElement();
  }

  for (Star s : stars) {
    s.drawElement();
  }

  for (Health r : healthItems) {
    r.drawElement();
  }

  player.drawElement();
}

// checks if the game is over
boolean isGameOver() {

  // if the user lost, game is lost and over
  if (health <= 0) {
    gameLost = true;
    return true;
    // if the user won, game is over
  } else if (meteors.get(meteorNum - 1).hasEnded()) {
    return true;
  }

  return false;
}


// checks collisions between the spaceship and other game elements
void checkCollisions() {

  // check if the player collected a star
  for (Star s : stars) {

    // if a star has appeared
    if (!s.hasEnded()) {

      // if it overlaps with the spaceship
      if ((player.xLoc() + (player.getWidth() / 2)) > (s.xLoc() - (s.getWidth()/2)) 
        && (player.xLoc() - (player.getWidth() / 2)) < (s.xLoc() + (s.getWidth()/2)) 
        && (player.yLoc() + (player.getHeight()/2)) > (s.yLoc() - (s.getHeight()/2))
        && (player.yLoc() - (player.getHeight()/2)) < (s.yLoc() + (s.getHeight()/2))) {
        collected.play();
        // increment the score
        score+= scoreAdd;
        // make the collectable dissapear
        s.endDuration();
      }
    }
  }

  // check if the player collected a health item
  for (Health s : healthItems) {

    // if a health item has appeared
    if (!s.hasEnded()) {

      // if it overlaps with the spaceship
      if ((player.xLoc() + (player.getWidth() / 2)) > (s.xLoc() - (s.getWidth()/2)) 
        && (player.xLoc() - (player.getWidth() / 2)) < (s.xLoc() + (s.getWidth()/2)) 
        && (player.yLoc() + (player.getHeight()/2)) > (s.yLoc() - (s.getHeight()/2))
        && (player.yLoc() - (player.getHeight()/2)) < (s.yLoc() + (s.getHeight()/2))) {
        healed.play();
        // boost health if needed
        if (health < 3) {
          health+= 1;
        }
        // make the health item dissapear
        s.endDuration();
      }
    }
  }

  // check if the player collided with meteors
  for (Meteor m : meteors) {

    // if a meteor appears
    if (!m.hasEnded()) {

      // check for overlaps with spaceship
      if ((m.xLoc() + (m.getWidth() / 2)) > (player.xLoc() - (player.getWidth()/2)) 
        && (m.xLoc() - (m.getWidth() / 2)) < (player.xLoc() + (player.getWidth()/2)) 
        && (m.yLoc() + (m.getHeight()/2)) > (player.yLoc() - (player.getHeight()/2))
        && (m.yLoc() - (m.getHeight()/2)) < (player.yLoc() + (player.getHeight()/2))) {
        crashed.play();
        // decrease the health
        health--;
        // end the duration of the meteor
        m.endDuration();
      }
    }
  }
}
