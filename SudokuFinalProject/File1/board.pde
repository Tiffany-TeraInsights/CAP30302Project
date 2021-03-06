class Board{
  
  int size = 9;
  float boardColor;
  int cellSize;
  
 
 // draws the lines of the sudoku board
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
  
  // formats the penciled in numbers if there are any
  void showPencil(IntList pencil[][]) {
    textAlign(CENTER,CENTER);
    fill(#619886);
    for (int i=0; i<9; i++) {
      for (int j=0; j<9; j++) {
        if(pencil[i][j].size()==0) {
        }
        else if(pencil[i][j].get(0)==0) {
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
          text(pencil[i][j].get(3), j*cellSize+cellSize/4*2, i*cellSize+cellSize/3*2);
          text(pencil[i][j].get(4), j*cellSize+cellSize/4*3, i*cellSize+cellSize/3*2);         
        }
        else if (pencil[i][j].size()==6) {
          textSize(18);
          text(pencil[i][j].get(0), j*cellSize+cellSize/4, i*cellSize+cellSize/3);
          text(pencil[i][j].get(1), j*cellSize+cellSize/4*2, i*cellSize+cellSize/3);
          text(pencil[i][j].get(2), j*cellSize+cellSize/4*3, i*cellSize+cellSize/3);         
          text(pencil[i][j].get(3), j*cellSize+cellSize/4, i*cellSize+cellSize/3*2);
          text(pencil[i][j].get(4), j*cellSize+cellSize/4*2, i*cellSize+cellSize/3*2);
          text(pencil[i][j].get(5), j*cellSize+cellSize/4*3, i*cellSize+cellSize/3*2);         
        }
      }
    }
  }
        
  // show the marked values in the puzzle
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
  
  //indicates whether or not the mouse is over the sudoku board
  boolean overSudokuBoard(){
    if(mouseX > 0 && mouseX < (width-150)){
      if(mouseY > 0 && mouseY < (height)){
       return true;   
      }
    }
    return false;
  }
  
  //validates user input with solution
  boolean checkInput(int input, int box, int solution[][]) {
    if(solution[box/9][box%9]==input) {
      return true;
    }
    else {
      return false;
    }
  }
  
  //returns the number of the sudoku box
  int boxNumber(){
    int colNum = mouseX/cellSize;
    int rowNum = mouseY/cellSize;
    return ((colNum) + (9 * (rowNum)));
  }
  
  // draws red border around selected box
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
  
  //check if the puzzle matches the solution
  boolean checkIfWon(int puzzle[][], int solution[][]){
    if(puzzle == solution){
      return true;
    }
    else{
      return false;
    }
  }
    
  
  Board(){
  }
  
  
  
}