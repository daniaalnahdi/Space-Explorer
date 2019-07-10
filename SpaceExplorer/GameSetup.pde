// the player in the game 
Spaceship player;
// list of meteors
ArrayList<Meteor> meteors;
// list of stars
ArrayList<Star> stars;
// list of healh items
ArrayList<Health> healthItems;
// game level
int level = 1;
// speed of meteors
int mSpeed;
// the number of meteors
int meteorNum;
// the number of stars
int starNum;
// the number of health items
int healthNum;
// the time the user starts playing the game
int gameStartTime;
// the time when enemies start to appear
int enemyStartTime;
// the duration for which the meteors appear
int enemyDur;
// inital score of the user
int score = 0;
// initial player's health items
int health = 3;
// if the game was lost
boolean gameLost;
// determine the score boost
int scoreAdd;
int totalScore = 0;


// sets up the game objects and variables
void gameSetup() {

  gameStartTime = millis();
  enemyStartTime = gameStartTime;

  player = new Spaceship(64, 64);
  meteors = new ArrayList();
  stars = new ArrayList();
  healthItems = new ArrayList();
  gameLost = false;
  health = 3;

  addMeteors();
  addStars();
  addHealth();
}

// set the game variables depending on the current level
void setDifficulty() {

  switch (level) {
  case 1:
    meteorNum = 60;
    starNum = 10;
    healthNum = 1;
    enemyDur = 850;
    mSpeed = 4;
    scoreAdd = 10;
    break;
  case 2:
    meteorNum = 100;
    starNum = 15;
    healthNum = 3;
    enemyDur = 400;
    mSpeed = 6;
    scoreAdd = 50;
    break;
  case 3:
    meteorNum = 160;
    starNum = 20;
    healthNum = 5;
    mSpeed = 7;
    enemyDur = 300;
    scoreAdd = 100;
    break;
  }
}

// generates the meteors at random positions
void addMeteors() {

  // the start time is when the meteor starts to appear
  int startTime = enemyStartTime;
  int xPos = 0;
  int enWidth = 0;

  for (int countPerCol = 0; countPerCol < meteorNum; countPerCol++) {

    // assign a random width to the meteor
    enWidth = (int) random(70, 110);

    // screen divided into four sections -- starts from left side
    switch (countPerCol % 4) {
      // assign the meteor's position to first section 
    case 0:
      xPos = ((int) random(50, 100)) - (enWidth/2);
      break;
      // assign the meteor's position to second section
    case 1:
      xPos = ((int) random(100, 350)) - (enWidth/2);
      break;
      // assign the meteor's position to third section
    case 2:
      xPos = ((int) random(350, 400)) - (enWidth/2);
      break;
      // assign the meteor's position to fourth section
    case 3:
      xPos = ((int) random(400, 550)) - (enWidth/2);
      break;
    }

    meteors.add(new Meteor(xPos, enWidth, startTime));

    // increment the start time for the next enemy
    startTime += enemyDur;
  }
}

// generates the stars at random positions
void addStars() {

  // the startTime is dependant on the appearance of enemies 
  int startTime = enemyStartTime;
  int xPos = 0;

  for (int countPerCol = 0; countPerCol < starNum; countPerCol++) {

    // screen divided into four sections -- starts from left side
    switch (countPerCol % 4) {
      // assign the stars's position to first section 
    case 0:
      xPos = ((int) random(50, 100));
      break;
      // assign the stars's position to second section 
    case 1:
      xPos = ((int) random(100, 350));
      break;
      // assign the stars's position to third section 
    case 2:
      xPos = ((int) random(350, 400));
      break;
      // assign the stars's position to four section 
    case 3:
      xPos = ((int) random(400, 550));
      break;
    }

    stars.add(new Star(xPos, 32, 32, startTime));

    // increment the start time for the next star
    startTime += 5000;
  }
}

// generates the health items at random positions
void addHealth() {

  // the startTime is dependant on the appearance of meteors 
  int startTime = enemyStartTime + 10000;
  int xPos = 0;

  for (int countPerCol = 0; countPerCol < starNum; countPerCol++) {

    // screen divided into two sections -- starts from right side
    switch (countPerCol % 2) {
      // assign the items's position to right side 
    case 0:
      xPos = ((int) random(16, width/2));
      break;
      // assign the items's position to left section 
    case 1:
      xPos = ((int) random(width/2, width-16));
      break;
    }

    healthItems.add(new Health(xPos, 16, 16, startTime));

    // increment the start time for the next item
    startTime += 7000;
  }
}
