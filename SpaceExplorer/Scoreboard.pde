/**
 The game scoreboard. Sorts and stores data from current and previous players/games.
 **/

import java.util.Collections;
import java.util.List;
import static java.lang.Integer.compare;

// default rankings for empty data
Rank firstPlace = new Rank("...", 0, 0);
Rank secondPlace = new Rank("...", 0, 0);
Rank thirdPlace = new Rank("...,", 0, 0);

// list of player data
List scoreboard = new ArrayList<Rank>();

// JSON data with all scores
JSONObject data;

// a class representing the ranking of a player
class Rank implements Comparable<Rank> {
  String name;
  int score;
  int level;

  Rank(String n, int s, int l) {
    this.name = n;
    this.score = s;
    this.level = l;
  }

  // returns the username
  String rankName() {
    return this.name;
  }

  // returns the score
  int rankScore() {
    return this.score;
  }

  // returns the level
  int rankLevel() {
    return this.level;
  }

  /**
   compares a player's ranking to another. returns:
   1 if this player ranks higher
   0 if both players are the same level
   -1 if this player ranks lower
   **/
  int compareTo(Rank other) {

    // compare their scores
    int d = compare(other.rankScore(), this.score);

    // if they have the same score
    if (d == 0) {
      // check level achieved
      d = compare(other.rankLevel(), this.level);
    }
    return d;
  }
}

// sets up the scoreboard data
void scoreboardSetup() {
  scoreboard.add(firstPlace);
  scoreboard.add(secondPlace);
  scoreboard.add(thirdPlace);

  // loads the data
  data = loadJSONObject("Scores.JSON");
  JSONArray scores = data.getJSONArray("scores");

  for (int i = 0; i < scores.size(); i++) {
    JSONObject rankData = scores.getJSONObject(i);

    String name = rankData.getString("sName");
    int score = rankData.getInt("sScore");
    int level = rankData.getInt("sLevel");

    Rank currRank = new Rank(name, score, level);
    scoreboard.add(currRank);
  }

  // sorts the data
  Collections.sort(scoreboard);
  // extracts top three rankings
  topThree();
}

// adds the current player's score to the data file
void addScore() {

  // create the JSON object
  JSONArray scores = data.getJSONArray("scores");
  JSONObject newScore = new JSONObject();

  newScore.setString("sName", username);
  newScore.setInt("sScore", score);
  newScore.setInt("sLevel", level);

  // appends to the data file
  scores.append(newScore);
  JSONObject updatedScores = new JSONObject();
  updatedScores.setJSONArray("scores", scores);
  saveJSONObject(updatedScores, "data/Scores.JSON");

  // sorts the updated data
  scoreboard.add(new Rank(username, score, level));
  Collections.sort(scoreboard);
  // extracts top three
  topThree();
}

// determines the top three rankings from the given data
void topThree() {

  for (int i = 0; i < 3; i++) {
    Rank r;

    // if there is enough data
    if (i < scoreboard.size()) {

      // get the ranking 
      r = (Rank) scoreboard.get(i);

      switch (i) {
        // set to first place
      case 0:
        firstPlace = r;
        break;
        // set to second place
      case 1:
        secondPlace = r;
        break;
        // set to third place
      case 2:
        thirdPlace = r;
        break;
      }
    }
  }
}
