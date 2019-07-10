/**
 Description:
 A game where the player is a spaceship. Use your mouse to avoid falling meteors,
 collect stars to boost your score, and collect hearts to heal from damage.
 
 Instructions:
 -Click on instructions to view game instructions.
 -Click on play to play the game.
 -Enter your name and pick a spaceship (you must do both first to start playing).
 -Play the game. If you lose, you can restart the same level.
 -If you win, move on to the next level until you win all three levels.
 -If you make it past the first level and got a high score, you
 will be featured in the scoreboard in the main menu.
 
 **/

// inital game state
int state = 0;

// sets up game variables, media, and data
void setup() {
  size(600, 600);

  //set up variables and load data/media
  loadMedia();
  inputSetup();
  scoreboardSetup();
  
  //starts playing the music
  background.loop();
}

// renders images and graphics
void draw() { 
  textFont(font);

  // draw depending on the current state
  switch(state) {
  case 0:
    startScreen();
    break;
  case 1:
    instructionsScreen();
    break;
  case 2:
    customizeScreen();
    break;
  case 3:
    gameScreen();
    break;
  case 4: 
    feedbackScreen();
    break;
  }
}

// handles user button clicks
void mouseClicked() {

  switch(state) {
  case 0:
    // go to the instructions
    if (pressedInstructions) {
      clicked.play();
      state = 1;
    }

    // go to customize the player
    if (pressedCustomize) {
      clicked.play();
      state = 2;
    }
    break;
  case 1:
    // go to the main menu
    if (pressedMenu) {
      clicked.play();
      state = 0;
    }

    break;
  case 2:
    // restart the game
    if (pressedRestart) {
      clicked.play();
      inputSetup();
      state = 0;
    }

    // start the game if user if all customization fields are filled
    if (pressedGame && allPicked) {
      clicked.play();
      setDifficulty();
      gameSetup();
      state = 3;
    } 

    // alert user that not all fields have been entered
    if (pressedGame && !allPicked) {
      denied.play();
    }

    // select first spaceship
    if (firstS) {
      clicked.play();
      pickedS = 1;
    }

    // select second spaceship
    if (secondS) {
      clicked.play();
      pickedS = 2;
    }

    break;
  case 4:

    // restart the game
    if (pressedRestart) {
      clicked.play();

      // add data to the scoreboard if past level 1
      if (gameLost && level > 1) {
        score = totalScore;
        level -= 1;
        addScore();
      } else if (!gameLost) {
        addScore();
      }

      // reset variables
      level = 1;
      inputSetup();
      gameSetup();
      setDifficulty();
      score = 0;
      totalScore = 0;
      state = 0;
    }

    // move on to the next level
    if (pressedNext && !gameLost && level < 3) {
      clicked.play();
      // set up new variables
      level = level + 1;
      totalScore = score;
      setDifficulty();
      gameSetup();
      state = 3;
    }

    // try the same level again
    if (pressedTry && gameLost) {
      clicked.play();
      // reset variables
      score = totalScore;
      setDifficulty();
      gameSetup();
      state = 3;
    }

    // close the window
    if (pressedQuit) {
      clicked.play();
      // add data to the scoreboard
      totalScore = score;
      addScore();
      exit();
    }
  }
}


// handles user key inputs
void keyTyped() {

  String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

  if (state == 2) {

    // saves the player's username
    if (alphabet.contains(str(key)) && username.length() <= 6) {
      typed.play();
      username += key;
      username = username.toUpperCase();
      // alert the user if the name is too long
    } else if (username.length() > 6) {
      denied.play();
    }
  }

  // enable backspacing
  if (key == BACKSPACE && username.length() > 0) {
    typed.play();
    username = username.substring(0, username.length()-1);
  }
}
