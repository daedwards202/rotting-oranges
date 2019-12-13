import java.util.Queue;
import java.util.LinkedList;

int rows;
int cols;
int iteration = 0;
boolean displayed = false;
boolean finished = false;
Queue<PairCoords> coords;

Cell[][] grid;
Cell currentCell;
void setup() {
  textSize(20);
  size(1000, 600);
  background(0);
  genGrid();
  coords = new LinkedList<PairCoords>();
  fillQueue();
  printCoords();
}

void printCoords() {
  for (PairCoords e : coords) {
    if (e.x == -1 && e.y == -1)
      print("(" + e.x + "," + e.y + ")");
    else 
      print("(" + e.x + "," + e.y + "), ");
  }
  println();  
}

void draw() {
  if (!displayed) {
    displayGrid();
    displayed = true;
  }
  if (keyPressed && !finished) { 
    if (keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT) {
      background(0);
      rotAll();
      displayGrid();
      if (!finished) {
        iteration++;
      }
    }
    delay(400);
  }
}

void genGrid() {
  int[][] orangeStates = {{2, 1, 0, 0, 1, 1, 0, 0, 0, 1},
                          {1, 0, 1, 1, 1, 2, 1, 0, 1, 1},
                          {1, 1, 0, 1, 1, 2, 1, 0, 1, 0},
                          {2, 1, 0, 0, 1, 1, 0, 1, 1, 1},
                          {0, 0, 1, 2, 0, 1, 0, 0, 2, 1},
                          {1, 0, 0, 0, 1, 0, 0, 1, 0, 1}};
  /*int[][] orangeStates = {{2, 1, 0, 2, 1},
                            {1, 0, 1, 2, 1},
                            {1, 0, 0, 2, 1}};*/
  /*int[][] orangeStates = {{2, 1, 0, 2, 1},
                            {0, 0, 1, 2, 1},
                            {1, 0, 0, 2, 1}};*/       
  rows = orangeStates.length;
  cols = orangeStates[0].length;
  grid = new Cell[rows][cols];
  for (int j = 0; j < rows; j++) 
    for (int i = 0; i < cols; i++) 
      grid[j][i] = new Cell(width/cols*i, height/rows*j, i, j, orangeStates[j][i]);
}

void displayGrid() {
  for (int j = 0; j < rows; j++) 
    for (int i = 0; i < cols; i++) 
        grid[j][i].display();
}

void fillQueue() {
  for (int j = 0; j < rows; j++) 
    for (int i = 0; i < cols; i++) 
      if (grid[j][i].val == 2) {
        coords.add(new PairCoords(i, j));
      }
  coords.add(new PairCoords(-1, -1));
}

void rotAll() {
  while (!isDelim(coords.peek()))  {
    PairCoords e = coords.peek();
    int x = e.x;
    int y = e.y;
    if (y != rows-1) {
      grid[y+1][x].rot();
    }
    if (y != 0) {
      grid[y-1][x].rot();
    }
    if (x != cols-1) {
      grid[y][x+1].rot();
    }
    if (x != 0) {
      grid[y][x-1].rot();
    }
    coords.remove();
  } 
  coords.remove();
  coords.add(new PairCoords(-1, -1));
  printCoords();
  if (isDelim(coords.peek())) {
    finished = true;
    if (allRotted())
      println("Iterations required: " + iteration);
    else 
      println("Cannot rot all oranges");
  }
}

boolean allRotted() {
  for (int j = 0; j < rows; j++) 
    for (int i = 0; i < cols; i++)
      if (grid[j][i].val == 1)
        return false;
  return true;
}

boolean isDelim(PairCoords e) {
  if (e.x == -1 && e.y == -1) 
    return true;
  return false;
}
