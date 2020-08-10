// Tommie Hatori-Hayes || thatorih || 20809270 || Final Project

int score[] = {0, 0}; //(4. arrays)
int multi[] = {1, 1};
int count[] = {0, 0};
int speed[] = new int[2];
int y[] = new int[2];
int x[] = new int[2];
boolean[] q = new boolean[2];
boolean[] w = new boolean[2];
boolean[] e = new boolean[2];
int high, wide, seconds, secondsCount, c, rad;
boolean on;

void setup() {
  size(600, 600);
  noCursor();
  
  high = 7 * height / 8;
  wide = width / 4;
  seconds = 0;
  secondsCount = int(frameCount / frameRate);
  rad = 5;
  for (int i = 0; i < 2; i++) { //(3. loops (1))
    speed[i] = int(random(4, 9)); //(6. built-in functions that return a value (1))
    y[i] = height / 4;
    x[i] = int(random(rad, width / 2 - rad)) + i * width / 2;
  }
}

void draw() {
  //designing the background (1. drawing shapes)
  background(0);
  fill(0, 255, 0);
  rect(0, high, width, 50);
  fill(255, 0, 0);
  rect(0, high + 50, width, 50);
  fill(255);
  rect(0, 0, width, height / 4);
  
  stroke(255);
  strokeWeight(1);
  line(wide - 50, 0, wide - 50, high + 50);
  line(wide + 50, 0, wide + 50, high + 50);
  line(3 * wide - 50, 0, 3 * wide - 50, high + 50);
  line(3 * wide + 50, 0, 3 * wide + 50, high + 50);
  
  strokeWeight(5);
  line(width / 2, 0, width / 2, height);
  line(0, height / 4, width, height / 4);
  line(0, high, width, high);
  line(0, high + 50, width, high + 50);

  //desigining the looks
  fill(0);
  textSize(30);
  textAlign(CENTER);
  text("A", wide - 100, high + 35);
  text("S", wide, high + 35);
  text("D", wide + 100, high + 35);
  text("J", 3 * wide - 100, high + 35);
  text("K", 3 * wide, high + 35);
  text("L", 3 * wide + 100, high + 35);

  //desigining the scoreboard
  text("PLAYER 1", wide, 40);
  text("PLAYER 2", 3 * wide, 40);
  text("Score: " + score[0], wide, 80);
  text("Score: " + score[1], 3 * wide, 80);
  text("Multiplier: x" + multi[0], wide, 120);
  text("Multiplier: x" + multi[1], 3 * wide, 120);

  //seconds timer and making the colour go from green to red as the timer runs down (2. conditionals (1))
  if (int(frameCount / frameRate) > secondsCount && on) {
    seconds++;
    secondsCount = int(frameCount / frameRate);
  }
  c = int(map(seconds, 0, 30, 255, 0)); //(6. built-in functions that return a value (2))
  fill(255 - c, c, 0);
  textSize(40);
  text(seconds, width / 2, height / 8);

  //increasing score when correct letters are pressed at correct time
  if (on) { //(2. conditionals (2))
    for (int i = 0; i < 2; i++) { //(3. loops (2))
      drawBall(x[i], y[i], 2 * rad);
      y[i] += speed[i];
      if (y[i] >= high + rad && y[i] <= high + 50 - rad && x[i] >= 0 + i * width / 2 && x[i] <= wide - 50 + i * width / 2 && q[i]) { //(7. hit tests (1), left lane)
        y[i] = height / 4;
        score[i] += multi[i];
        speed[i] = int(random(4, 9));
        x[i] = int(random(rad, width / 2 - rad)) + i * width / 2;
        count[i]++;
      } else if (y[i] >= high + rad && y[i] <= high + 50 - rad && x[i] >= wide - 50 + i * width / 2 && x[i] <= wide + 50 + i * width / 2 && w[i]) { //(7. hit tests (2), middle lane)
        y[i] = height / 4;
        score[i] += multi[i];
        speed[i] = int(random(4, 9));
        x[i] = int(random(rad, width / 2 - rad)) + i * width / 2;
        count[i]++;
      } else if (y[i] >= high + rad && y[i] <= high + 50 - rad && x[i] >= wide + 50 + i * width / 2 && x[i] <= width / 2 + i * width / 2 && e[i]) { //(7. hit tests (3), right lane)
        y[i] = height / 4;
        score[i] += multi[i];
        speed[i] = int(random(4, 9));
        x[i] = int(random(rad, width / 2 - rad)) + i * width / 2;
        count[i]++;
      } else if (y[i] > high + 50 - rad) { //(7. hit tests (4), ball hits red zone)
        y[i] = height / 4;
        speed[i] = int(random(4, 9));
        x[i] = int(random(rad, width / 2 - rad)) + i * width / 2;
        count[i] = 0;
        multi[i] = 1;
      }

      //if you hit five balls in a row the multiplier goes up by 1
      if (count[i] == 5) {
        count[i] = 0;
        multi[i]++;
      }
    }
  } else if (!on && score[0] == 0 && score[1] == 0 && seconds == 0) {  //displaying this message only at the beginning of the game
    fill(255, 0, 0);
    textSize(40);
    text("Press mouse to begin", width / 2, height / 2);
  }

  //ending game at 30 seconds and displaying the winner
  if (seconds >= 30) {
    on = false;
    fill(255, 0, 0);
    textSize(40);
    text("Press mouse to play again", width / 2, height / 2 + 50);
    if (score[0] > score[1]) {
      text("PLAYER 1 WINS", width / 2, height / 2);
    } else if (score[0] < score[1]) {
      text("PLAYER 2 WINS", width / 2, height / 2);
    } else if (score[0] == score[1]) {
      text("DRAW", width / 2, height / 2);
    }
  }
}

void keyPressed() { //(8. event functions (1))
  //activating each boolean when keys are pressed
  if (key == 'a') {
    q[0] = true;
    w[0] = false;
    e[0] = false;
  } else if (key == 's') {
    q[0] = false;
    w[0] = true;
    e[0] = false;
  } else if (key == 'd') {
    q[0] = false;
    w[0] = false;
    e[0] = true;
  }
  if (key == 'j') {
    q[1] = true;
    w[1] = false;
    e[1] = false;
  } else if (key == 'k') {
    q[1] = false;
    w[1] = true;
    e[1] = false;
  } else if (key == 'l') {
    q[1] = false;
    w[1] = false;
    e[1] = true;
  }
}

void keyReleased() {
  //making sure that keys are pressed exactly at the right time to score points
  if (key == 'a' || key == 's' || key == 'd') {
    q[0] = false;
    w[0] = false;
    e[0] = false;
  } else if (key == 'j' || key == 'k' || key == 'l') {
    q[1] = false;
    w[1] = false;
    e[1] = false;
  }
}

void mousePressed() { //(8. event functions (2))
  //start and restart each game by pressing the mouse
  on = true;
  seconds = 0;
  for (int i = 0; i < 2; i++) {
    score[i] = 0; 
    multi[i] = 1;
    count[i] = 0;
    speed[i] = int(random(4, 9));
    y[i] = height / 4;
    x[i] = int(random(rad, width / 2 - rad)) + i * width / 2;
  }
}

void drawBall(int x, int y, int d) { //(5. user-defined functions)
  fill(0, 0, 255);
  noStroke();
  ellipse(x, y, d, d);
}