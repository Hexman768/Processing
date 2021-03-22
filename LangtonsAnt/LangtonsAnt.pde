int[][] board;
int x;
int y;
PImage ant;

int dUP = 0;
int dLEFT = -1;
int dRIGHT = 1;
int dDOWN = 2;
int dir = dUP;

void setup() {
  size(600, 600);
  x = int(random(width));
  y = int(random(height));
  board = new int[width][height];
  ant = createImage(width, height, RGB);
  ant.loadPixels();
  for (int i = 0; i < ant.pixels.length; i++) {
    ant.pixels[i] = color(255);
  }
  ant.updatePixels();
}

void moveForward() {
  if (dir == dUP) { y -= 1; }
  else if (dir == dRIGHT) { x += 1; }
  else if (dir == dLEFT) {x -= 1; }
  else { y += 1; }
  if (x > width - 1) { x = 0; }
  else if (x < 0) { x = width - 1; }
  if (y < 0) { y = height - 1; }
  else if (y > height - 1) { y = 0; }
}

void turnLeft() {
  if (dir == dLEFT) { dir = dDOWN; }
  else { dir -= 1; }
}

void turnRight() {
  if (dir == dDOWN) { dir = dLEFT; }
  else { dir += 1; }
}


void draw() {
  background(255);
  ant.loadPixels();
  color col;
  for (int i = 0; i < 1000; i++) {
    if (board[x][y] == 0){
      col = color(255);
      turnRight();
      board[x][y] = 1;
      moveForward();
    } else {
      col = color(0);
      turnLeft();
      board[x][y] = 0;
      moveForward();
    }
    int loc = x + y * ant.width;
    ant.pixels[loc] = col;
  }
  ant.updatePixels();
  image(ant,0,0);
}
