int resolution = 10;
static final int[][] neighbors = {
    {-1, -1}, {-1, 0}, {-1, +1},
    { 0, -1},          { 0, +1},
    {+1, -1}, {+1, 0}, {+1, +1}};

Cell[][] board;
int cols;
int rows;

Cell[][] createBoard(int rows, int cols) {
  Cell [][] board = new Cell[rows][cols];
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int val = floor(random(2));
      boolean isAlive = false;
      if (val == 1) { isAlive = true; }
      board[i][j] = new Cell(isAlive);
    }
  }
  return board;
}

void setup() {
  size(600, 400);
  cols = width / resolution;
  rows = height / resolution;
  board = createBoard(rows, cols);
}

void draw() {
  background(0);
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      fill(255);
      if (board[i][j].isAlive()) { fill(0); }
      stroke(0);
      rect(j * resolution, i * resolution, resolution - 1, resolution - 1);
    }
  }
  gameLogic();
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      board[i][j].setAlive(board[i][j].nextAlive());
    }
  }
  delay(100);
}

void gameLogic() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int neighbors = getNeighbors(i, j);
      if (board[i][j].isAlive() && (neighbors == 2 || neighbors == 3)) { board[i][j].setNextAlive(true); }
      else if (!board[i][j].isAlive() && neighbors == 3) { board[i][j].setNextAlive(true); }
      else { board[i][j].setNextAlive(false); }
    }
  }
}

int getNeighbors(int row, int col) {
  int count = 0;
  for (int[] offset : neighbors) {
    if (hasNeighborAt(row + offset[0], col + offset[1])) { count++; }
  }
  return count;
}

boolean hasNeighborAt(int row, int col) {
  if (col < 0 || row < 0 || col >= cols || row >= rows) { return false; }
  return board[row][col].isAlive();
}

public class Cell {
  private boolean isAlive;
  private boolean nextAlive;
  
  public Cell(boolean alive) {
    this.isAlive = alive;
    this.nextAlive = false;
  }
  
  public void setAlive(boolean alive) {
    this.isAlive = alive;
  }
  
  public void setNextAlive(boolean nextAlive) {
    this.nextAlive = nextAlive;
  }
  
  public boolean isAlive() {
    return isAlive;
  }
  
  public boolean nextAlive() {
    return nextAlive;
  }
}
