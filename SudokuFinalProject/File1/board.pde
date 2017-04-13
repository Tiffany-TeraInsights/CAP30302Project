class Board{
  
  int size = 9;
  float boardColor;
  int cellSize;
  
  
  void drawBoard(){
    stroke(0);
    fill(255, 255, 255, 190);
    rect(0,0,(width-150),height);
    cellSize = ((width-150))/size;
    for (int i=0; i<10; i++) {
    // change stroke weight
    if (i%3 == 0)
      strokeWeight(3);
    else
      strokeWeight(1);
    line(i*cellSize, 0, i*cellSize, (height));
    line(0, i*cellSize, (width-150), i*cellSize);
  }
  strokeWeight(3);
  line(width-2, 0, width-2, height);
  line(0, height-2, (width - 150), height-2);
    
  }
  
  void showNumbers(int puzzle[][]){
    for (int i=0; i<9; i++) {
      for (int j=0; j<9; j++) {
        textAlign(CENTER,CENTER);
        textSize(35);
        fill(0);
        if (puzzle[i][j]!=0) {
          text(puzzle[i][j], j*cellSize+cellSize/2, i*cellSize+cellSize/2);
        }
      }
    }
  }
  
  boolean overSudokuBoard(){
    if(mouseX > 0 && mouseX < (width-150)){
      if(mouseY > 0 && mouseY < (height)){
       return true;   
      }
    }
    return false;
  }
  
  boolean checkInput(int input, int box, int solution[][]) {
    if(solution[box/9][box%9]==input) {
      return true;
    }
    else {
      return false;
    }
  }
  
  
  int boxNumber(){
    int colNum = mouseX/cellSize;
    int rowNum = mouseY/cellSize;
    return ((colNum) + (9 * (rowNum)));
  }
  
  void drawInBox(){
    int colNum = mouseX/cellSize;
    int rowNum = mouseY/cellSize;
    fill(0);
    stroke(0);
    rect(colNum*cellSize,rowNum*cellSize,cellSize,cellSize);
  }
  
  void drawCursor(int xMouse, int yMouse) {
    int colNum = xMouse/cellSize;
    int rowNum = yMouse/cellSize;
    int x = colNum*cellSize + 10;
    int y = (rowNum+1)*cellSize - 10;

  line(x, y, x+cellSize-20, y);
}
    
  Board(){
  }
  
  
  
}