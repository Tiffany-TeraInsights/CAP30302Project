class Board{
  
  int size = 9;
  float boardColor;
  int cellSize;
  
  
  void drawBoard(){
    stroke(0);
    fill(255, 255, 255, 190);
    rect(0,0,width-150,height-150);
    cellSize = ((width - 150))/size;
    for (int i=0; i<10; i++) {
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
  
  void showPencil(IntList pencil[][]) {
    textAlign(CENTER,CENTER);
    fill(#5EB791);
    for (int i=0; i<9; i++) {
      for (int j=0; j<9; j++) {
        if(pencil[i][j].get(0)==0) {
        }
        else if (pencil[i][j].size()==1) {
          textSize(30);
          text(pencil[i][j].get(0), j*cellSize+cellSize/2, i*cellSize+cellSize/2);
        }
        else if (pencil[i][j].size()==2) {
          textSize(25);
          text(pencil[i][j].get(0), j*cellSize+cellSize/3, i*cellSize+cellSize/2);
          text(pencil[i][j].get(1), j*cellSize+cellSize/3*2, i*cellSize+cellSize/2);
        }
        else if (pencil[i][j].size()==3) {
          textSize(20);
          text(pencil[i][j].get(0), j*cellSize+cellSize/2, i*cellSize+cellSize/3);
          text(pencil[i][j].get(1), j*cellSize+cellSize/3, i*cellSize+cellSize/3*2);
          text(pencil[i][j].get(2), j*cellSize+cellSize/3*2, i*cellSize+cellSize/3*2);
        }
        else if (pencil[i][j].size()==4) {
          textSize(20);
          text(pencil[i][j].get(0), j*cellSize+cellSize/3, i*cellSize+cellSize/3);
          text(pencil[i][j].get(1), j*cellSize+cellSize/3*2, i*cellSize+cellSize/3);
          text(pencil[i][j].get(2), j*cellSize+cellSize/3, i*cellSize+cellSize/3*2);
          text(pencil[i][j].get(3), j*cellSize+cellSize/3*2, i*cellSize+cellSize/3*2);         
        }
        else if (pencil[i][j].size()==5) {
          textSize(18);
          text(pencil[i][j].get(0), j*cellSize+cellSize/3, i*cellSize+cellSize/3);
          text(pencil[i][j].get(1), j*cellSize+cellSize/3*2, i*cellSize+cellSize/3);
          text(pencil[i][j].get(2), j*cellSize+cellSize/4, i*cellSize+cellSize/3*2);
          text(pencil[i][j].get(3), j*cellSize+cellSize/2, i*cellSize+cellSize/3*2);
          text(pencil[i][j].get(4), j*cellSize+cellSize/4*3, i*cellSize+cellSize/3*2);         
        }
        else if (pencil[i][j].size()==6) {
          textSize(18);
          text(pencil[i][j].get(0), j*cellSize+cellSize/4, i*cellSize+cellSize/3);
          text(pencil[i][j].get(1), j*cellSize+cellSize/2, i*cellSize+cellSize/3);
          text(pencil[i][j].get(2), j*cellSize+cellSize/4*3, i*cellSize+cellSize/3);         
          text(pencil[i][j].get(3), j*cellSize+cellSize/4, i*cellSize+cellSize/3*2);
          text(pencil[i][j].get(4), j*cellSize+cellSize/2, i*cellSize+cellSize/3*2);
          text(pencil[i][j].get(5), j*cellSize+cellSize/4*3, i*cellSize+cellSize/3*2);         
        }
      }
    }
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
      if(mouseY > 0 && mouseY < (height-150)){
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
      println("YOU BROKE IT");
      return false;
    }
  }
  
  int boxNumber(){
    int colNum = mouseX/cellSize;
    int rowNum = mouseY/cellSize;
    return ((colNum) + (9 * (rowNum)));
  }
  
  void drawCursor(int xMouse, int yMouse) {
    stroke(255,0,0);
    strokeWeight(2);
    noFill();
    int colNum = xMouse/cellSize;
    int rowNum = yMouse/cellSize;
    int x = colNum*cellSize;
    int y = rowNum*cellSize;
    rect(x, y, cellSize, cellSize);
  }
    
  
  Board(){
  }
  
  
  
}