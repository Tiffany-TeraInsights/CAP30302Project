class Board{
  
  int size = 9;
  float boardColor;
  int cellSize;
  
  
  void drawBoard(){
    stroke(0);
    fill(255, 255, 255, 190);
    rect(0,0,width-150,height-150);
    cellSize = ((width - 150))/size;
    for (int i=0; i<9; i++) {
    // change stroke weight
    if (i%3 == 0)
      strokeWeight(3);
    else
      strokeWeight(1);
    line(i*cellSize, 0, i*cellSize, (height-150));
    line(0, i*cellSize, (width - 150), i*cellSize);
  }
  strokeWeight(3);
  line(width-2, 0, width-2, (height-150));
  line(0, height-2, (width - 150), height-2);
    
  }
  
  void showNumbers(){
    
  }
  
  boolean overSudokuBoard(){
    if(mouseX > 0 && mouseX < (width-150)){
      if(mouseY > 0 && mouseY < (height-150)){
       return true;   
      }
    }
    return false;
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
  
  void drawCursor() {
    int colNum = mouseX/cellSize;
    int rowNum = mouseY/cellSize;
    int x = colNum*cellSize + 10;
    int y = (rowNum+1)*cellSize - 10;

  line(x, y, x+cellSize-20, y);
}
    
  Board(){
  }
  
  
  
}