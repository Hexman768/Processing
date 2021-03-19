int width = 600;
int height = 400;

int cols;
int rows;

int resolution = 10;

Cell[][] board;

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
      int neighbors = getLiveNeighbors(i, j);
      if (board[i][j].isAlive() && (neighbors == 2 || neighbors == 3)) { print("setting alive"); board[i][j].setNextAlive(true); }
      else if (!board[i][j].isAlive() && neighbors == 3) { board[i][j].setNextAlive(true); }
      else { board[i][j].setNextAlive(false); }
    }
  }
}

int getLiveNeighbors(int row, int col) {
  int count = 0;
  if (row != 0 && row != rows - 1) {
    if (col != 0 && col != cols - 1) {
      if (board[row - 1][col - 1].isAlive()) { count++; }
      if (board[row - 1][col].isAlive()) { count++; }
      if (board[row - 1][col + 1].isAlive()) { count++; }
      
      if (board[row][col - 1].isAlive()) { count++; }
      if (board[row][col + 1].isAlive()) { count++; }
      
      if (board[row + 1][col - 1].isAlive()) { count++; }
      if (board[row + 1][col].isAlive()) { count++; }
      if (board[row + 1][col + 1].isAlive()) { count++; }
    }
  }
  return count;
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
