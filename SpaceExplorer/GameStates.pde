// representing interface buttons
boolean pressedInstructions;
boolean pressedCustomize;
boolean pressedMenu;
boolean pressedGame;
boolean firstS;
boolean secondS;
boolean pressedRestart;
boolean pressedNext;
boolean pressedTry;
boolean pressedQuit;

// fields for the user to customize
int pickedS;
String username;
boolean allPicked;


// renders the main menu
void startScreen() {

  drawBackground();

  // renders the text
  formatHeading();
  text("Space Explorer", width/2, headingH);
  textSize(18);
  text("Hop on a spaceship to go on a", width/2, headingH + 45);
  text("journey through space!", width/2, headingH + 75);

  // renders the buttons
  strokeWeight(2);
  pressedCustomize = button(width - width/3, height - height/4, 180, 75, "Play game");  
  pressedInstructions = button(width/3, height - height/4, 180, 75, "How to play");

  // renders the scoreboard
  fill(255, 215, 0);
  textAlign(LEFT);
  text(firstPlace.rankName(), width/2 - width/3, headingH + 135);
  text(secondPlace.rankName(), width/2 - width/3, headingH + 165);
  text(thirdPlace.rankName(), width/2 - width/3, headingH + 195);

  textAlign(CENTER);
  text("LVL " + firstPlace.rankLevel(), width/2, headingH + 135);
  text("LVL " + secondPlace.rankLevel(), width/2, headingH + 165);
  text("LVL " + thirdPlace.rankLevel(), width/2, headingH + 195);

  textAlign(RIGHT);
  text(firstPlace.rankScore(), width/2 + width/3, headingH + 135);
  text(secondPlace.rankScore(), width/2 + width/3, headingH + 165);
  text(thirdPlace.rankScore(), width/2 + width/3, headingH + 195);
}

// renders the instructions screen
void instructionsScreen() {

  drawBackground();

  // renders the text
  formatHeading();
  text("How to Play", width/2, headingH);
  textSize(16);
  text("Move your mouse to control your", width/2, headingH + 45);
  text("spaceship, but watch out from the", width/2, headingH + 75);
  text("incoming meteors!", width/2, headingH + 105);
  text("Collect stars to boost your score!", width/2, headingH + 165);
  text("Collect hearts to heal from damage!", width/2, headingH + 225);

  // renders the buttons
  strokeWeight(2);
  pressedMenu = button(width/2, height - height/4, 180, 75, "Main Menu");
}

// renders the customization screen
void customizeScreen() {

  drawBackground();

  // renders the text
  formatHeading();
  text("Pick a spaceship", width/2, headingH);
  textSize(18);
  textAlign(LEFT);
  text("Enter your name: ", width/2 - 165, headingH + 45);

  // renders typed username
  fill(255, 215, 0);
  text(username, width/2 + 65, headingH + 45);


  // renders the buttons

  // outline when selected
  if (pickedS == 1) {
    stroke(255, 215, 0);
  }

  strokeWeight(2);
  firstS = button(width/3, height/2, 180, 140, "");
  image(ship1, width/3 - 30, height/2 - 30);

  // outline when selected
  if (pickedS == 2) {
    stroke(255, 215, 0);
  }

  strokeWeight(2);
  secondS = button(width - width/3, height - height/2, 180, 140, "");
  image(ship2, width - width/3 - 30, height - height/2 - 30);

  pressedRestart = button(width/3, height - height/4, 180, 75, "Go back");
  pressedGame = button(width - width/3, height - height/4, 180, 75, "Start");

  // checks if the user entered all fields
  if (!username.equals("") && pickedS > 0) {
    allPicked = true;
  } else {
    allPicked = false;
  }
}


// renders the game as it is being played
void gameScreen() {

  noCursor();
  drawBackground();
  drawGameElements();
  checkCollisions();
  formatHeading();

  // render's the player's information
  fill(0);
  rect(20, 20, 180, 100);
  textSize(16);
  textAlign(LEFT);
  fill(255);
  text(username, 30, 40); 
  text("lvl " + level, 30, 60); 
  text("score " + score, 30, 80);


  // renders filled/unfilled health items
  int hPos = 30;

  for (int i = 0; i < 3; i ++) {
    if (i < health) {
      image(healthItem, hPos, 90);
    } else {
      image(emptyLifeItem, hPos, 90);
    }
    hPos += 20;
  }

  // checks if the game is over
  if (isGameOver()) {
    state = 4;
  }
}

// renders the feedback after the game is over
void feedbackScreen() {
  cursor();
  drawBackground();

  // feedback if the game had been lost
  if (gameLost) {

    // renders text
    formatHeading();
    text("You crashed!", width/2, headingH);
    textSize(18);
    text("Better luck on your next trip!", width/2, headingH + 45);
    strokeWeight(2);

    // renders the buttons
    pressedRestart = button(width/3, height/2, 180, 75, "Go back");
    pressedTry = button(width - width/3, height/2, 180, 75, "Try Again");

    // feedback for when the game is won
  } else {

    // if the user won all three levels
    if (level == 3) {

      // renders the text
      formatHeading();
      text("Congratulations! You won!", width/2, headingH);
      textSize(18);
      text("Hope you enjoyed the ride!", width/2, headingH + 45);
      strokeWeight(2);

      // renders the buttons
      pressedRestart = button(width/3, height/2, 180, 75, "Play Again");
      pressedQuit = button(width - width/3, height/2, 180, 75, "Quit");


      // if the user won level 1 or 2
    } else {

      // renders the text
      formatHeading();
      text("You did it!", width/2, headingH); 
      textSize(18);
      text("Ready to go on your next adventure?", width/2, headingH + 45);

      // renders the button
      strokeWeight(2);
      pressedRestart = button(width/3, height/2, 180, 75, "Go back");
      pressedNext = button(width - width/3, height/2, 180, 75, "Next Level");
    }
  }
}

// sets up inital values for user input
void inputSetup() {

  pressedInstructions = false;
  pressedCustomize = false;
  pressedMenu = false;
  pressedGame = false;
  firstS = false;
  secondS = false;
  pressedRestart = false;
  pressedNext = false;
  pressedTry = false;
  pressedQuit = false;
  allPicked = false;
  pickedS = 0;
  username = "";
}

// renders the buttons
boolean button(int x, int y, int w, int h, String s) {
  fill(0);
  rect(x-w/2, y-h/2, w, h);
  fill(255);
  textSize(18);
  text(s, x, y+10);
  textAlign(CENTER);
  stroke(255);
  strokeWeight(2);

  if (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 &&
    mouseY < y+h/2) {
    //mouse is over the start button
    return true;
  } else {
    return false;
  }
}
