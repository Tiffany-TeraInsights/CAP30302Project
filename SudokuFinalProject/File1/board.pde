class Board{
  
  int size;
  float boardColor;
  int cellSize;
  
  
  void drawBoard(){
    cellSize = (width)/size;
    for (int i=0; i<9; i++) {
    // change stroke weight
    if (i%3 == 0)
      strokeWeight(3);
    else
      strokeWeight(1);
    line(i*cellSize, 0, i*cellSize, height);
    line(0, i*cellSize, width, i*cellSize);
  }
  // fix the last line
  strokeWeight(3);
  line(width-2, 0, width-2, height);
  line(0, height-2, width, height-2);
    
  }
  
  void showNumbers(){
    
  }
  
  
  
  Board(float bc){
    boardColor = bc;
  }
  
  
  
}