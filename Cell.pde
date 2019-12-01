class Cell {
  
  float x, y;
  int i, j;
  boolean occupied;
  int val;
  
  public Cell(float x, float y, int i, int j, int val) {
    this.x = x;
    this.y = y;
    this.i = i;
    this.j = j;
    this.val = val;
  }
  
  void rot() {
    if (val == 1) {
      val++;
      coords.add(new PairCoords(this.i, this.j));
    }
  }
 
  void display() {
    if (val == 1 || val == 2) {
      noStroke();
      if (val == 1) {
        if (adjacentToRotting())
          fill(200, 0, 0);
        else 
          fill(0);
        rect(x, y, width/cols, height/rows); 
        fill(255, 166, 0);
      } else if (val == 2) 
        fill(0, 255, 100);      
      ellipse(x+(width/cols)/2, y+(height/rows)/2, 2*width/(cols*3), 2*height/(rows*3));
      fill(255);
    }
    if (val == 0) {
      fill(255);
      rect(x, y, width/cols, height/rows);
      fill(0);
    }
    textAlign(LEFT, TOP);
    text(val, x+10, y+10);
  }
  
  boolean adjacentToRotting() {
    if (i != 0)
      if (grid[j][i-1].val == 2) return true;
    if (i != cols - 1)
      if (grid[j][i+1].val == 2) return true;
    if (j != 0)
      if (grid[j-1][i].val == 2) return true;
    if (j != rows - 1)
      if (grid[j+1][i].val == 2) return true;
    return false;
  }
}
