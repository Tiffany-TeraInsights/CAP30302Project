//Project Yo
//Added change
/*
gameState is used to dictate what "page" of the game we are on.
0 is the Main Menu
1 is Sudoku Game
2 is Mini Game
*/
int gameState = 0;
int difficulty;
int x;
int y;
int box;
boolean boxSelected=false;
Button B3;
Button B4;
Board sudokuBoard;
Button wheelGame;
Button quit;
Button activateHint;
Timer Time;
Puzzle puzzle;
Points points;
Errors errors;
int powerBarStrength = 105; //Beginning value for power bar.
minigame fortuneWheel = new minigame(90);
boolean oneSpin = true;
boolean checkRewardOnce = true;
Button returnSudoku;
String gambleReward = "";
Button pencil;
Button mark;
int mode = 0;

void setup(){
  size(600,450);
  background(#B87E3E);
  //frameRate = 1;
  Time = new Timer();
  puzzle=new Puzzle();
  points = new Points();
  errors = new Errors();
}

void draw(){
  
  if(gameState == 0) //If we're in the menu.
  {
    background(#B87E3E);
    
    //Background image stuff
    PImage image = loadImage("SudokuMainPic.jpg");
    image(image,width/4,height/8);
    
    //CREATE BUTTONS
    B3 = new Button(200,70,90,365,"Easy", #1CE86F, #1EBC5E, #1B7941, #FCFFFD);
    B4 = new Button(200,70,310,365,"Hard", #D33526, #BF3023, #933128, #FCFFFD);
    
    //Update buttons
    B3.update();
    B4.update(); //<>//
 //<>//
  } //<>// //<>// //<>//
  else if(gameState == 1) //Sudoku Puzzle. //<>// //<>//
  { //<>// //<>// //<>//
    //Keep background color the same. //<>//
    background(#B87E3E); //<>// //<>//
     //<>//
    // Realistic Bamboo Background. //<>// //<>//
    //Draw Sudoku Background //<>// //<>//
    PImage mainWoodBackground = loadImage("Bamboo Texture 2.jpg"); //<>//
    image(mainWoodBackground, 0, 0); //<>//
     //<>//
    sudokuBoard = new Board(); //<>// //<>//
    sudokuBoard.drawBoard(); //<>// //<>//
    sudokuBoard.showNumbers(puzzle.p);
    if (boxSelected) { //<>//
      sudokuBoard.drawCursor(x,y); //<>//
    }
    //<>//
    //Shadow of side menu
    fill(0);
    noStroke();
    rectMode(CORNERS); //<>//
    rect(445, 0, 600, 600); //<>//
    
    //Draw Side Menu Background
    PImage sideMenuBackground = loadImage("Side Menu Bamboo.jpg");
    image(sideMenuBackground, 450, -180);
    
    rectMode(CORNER);

    wheelGame = new Button(100, 30, 475, 250, "", #458B86, #68AFB2, #156164, #C2CECE);
    wheelGame.isOver();
    wheelGame.update();
    textSize(14);
    fill(255);
    textAlign(LEFT);

    activateHint = new Button(100, 30, 475, 300, "", #B4EBED, #68AFB2, #156164, #C2CECE);
    text("Mini Game", 480, 250);

    //activateHint
    activateHint.isOver();

    activateHint.update();
    textSize(14);
    fill(255);
    textAlign(LEFT);

    text("Hint", 480, 300);

    //quit
    quit = new Button(100, 30, 475, 400, "", #B4EBED, #68AFB2, #156164, #C2CECE);

    text("Hint", 480, 320);
    
    mark = new Button(100, 30, 475, 340, "", #458B86, #68AFB2, #156164, #C2CECE);
    mark.isOver();
    mark.update();
    textSize(14);
    fill(255);
    textAlign(LEFT);
    text("Mark", 480, 360);
    
    pencil = new Button(100, 30, 475, 340, "", #458B86, #68AFB2, #156164, #C2CECE);
    pencil.isOver();
    pencil.update();
    textSize(14);
    fill(255);
    textAlign(LEFT);
    text("Pencil", 480, 360);
    
    //quit
    quit = new Button(100, 30, 475, 400, "", #458B86, #68AFB2, #156164, #C2CECE);
    quit.isOver();

    quit.update();
    textSize(14);
    fill(255);
    textAlign(LEFT);
    text("Quit", 480, 420);
    
    Time.advance();
    textSize(20);
    fill(255);
    text(Time.hour() + ":" + Time.minute() + ":" + Time.second(), 500,100);
    
    
    //Score
    textSize(16);
    fill(255);
    text("Score: " + points.returnPoints(), 460, 150);
    text("Errors: " + errors.returnErrors(), 460, 180);

    
    //Cartoony Menu
    /*
    //Side Menu Shadow.
    fill(0);
    noStroke();
    rectMode(CORNERS);
    rect(448, 0, 600, 600);
    
    //Side Menu
    fill(#7C4306);
    rect(450, 0, 600, 600);
    */
    
    /*if(difficulty == 0)
    {
      //puzzle.easy();
    }
    else if(difficulty == 1) 
    {
      puzzle.hard();
    }*/
  }
  else if(gameState == 2)
  {
    fortuneWheel.display();
    
    rectMode(CORNER);
    returnSudoku = new Button(100, 30, 250, 400, "", #E56E1E, #863A07, #FC8608, #0F0F0E);
    if(fortuneWheel.doneSpinning() && checkRewardOnce)
    {
      gambleReward = fortuneWheel.getReward();
      checkRewardOnce = false;
      
      /* Colors
      Teal = 2x Score
      Magenta = 3x Score
      Orange = Reduce Hint Cost
      Blue = +1 Error
      Red = Half Score
      Green = No Points
      Purple = 2x Hint Cost
      Lime = Bring Errors to One.
      */
    }
    
    if(fortuneWheel.doneSpinning() && checkRewardOnce == false)
    {
      returnSudoku.isOver();
      returnSudoku.update();
      textSize(20);
      text("Return", 260, 425);
    }
  }
}

void mouseClicked()
{
  if(gameState == 0) //Only occurs when in the Main Menu
  {
    B3.isOver();
    B4.isOver();
    if(B3.over) //If mouse if over button
    {
      difficulty=0;
      puzzle.easy();
      gameState = 1; //Bring us to Sudoku.
    }
    else if(B4.over) //If mouse is over button
    {
      difficulty=1;
      puzzle.hard();
      gameState = 1; //Bring us to Sudoku.
    }
    else
    {
      //Do Nothing
    }
  }
  else if(gameState == 1) //If we're in Sudoku.
  {
    wheelGame.isOver();
    activateHint.isOver();
    quit.isOver();
    pencil.isOver();
    mark.isOver();
    if(wheelGame.over) //If the mouse is over the button.
    {
      gameState = 2; //Move Us to Mini Game State.
    }
    else if(activateHint.over)
    {
      
    }
    else if(quit.over)
    {
      gameState = 0;
    }
    else if(mark.over)
    {
      mode = 0;
    }
    else if(pencil.over)
    {
      mode = 1;
    }
    
    
    if(sudokuBoard.overSudokuBoard() == true){
       //if (!boxSelected) {
         box=sudokuBoard.boxNumber();
         if (puzzle.p[box/9][box%9]==0) {
           boxSelected=true;
           x=mouseX;
           y=mouseY;
         }
       //}
    }
    else {
      boxSelected=false;
    }
  }
  else if(gameState == 2)
  {
    returnSudoku.isOver();
    if(returnSudoku.over)
    {
      gameState = 1;
      
      //Reset all of minigame.
      oneSpin = true;
      checkRewardOnce = true;
      fortuneWheel.resetValues();
    }
  }
  else if(gameState == 3){
    PImage loseBackground = loadImage("youjustlost.jpg");
    image(loseBackground, 450, -180);
  }
}

void keyPressed()
{
  //Only do the following if we're inside the minigame.
  if(gameState == 2) 
  {
    //Increasing powerbar and updating it for the Minigame.
    if(key == 'w' && oneSpin) //If the key pressed is W.
    {
      if(powerBarStrength < 495) //And We haven't hit maximum.
      {
        powerBarStrength = powerBarStrength + 2; //Increase Power.
        fortuneWheel.setDrawPower(powerBarStrength); //Update Power.
      }
    }
  }
  if(gameState == 1){
   /* if(inputMode && m[rowNum][colNum] == 0 && key>='0' && key<='9') {
       m[rowNum][colNum] = key - '0'; // '0'
      inputMode = false;
    } */
  }
}

void keyReleased()
{
  //Only do the following if we're inside the minigame.
  if(gameState == 2)
  {
    if(key == 'w' && oneSpin) //If the key was "w" meaning we were charging the powerbar.
    {
      fortuneWheel.setSpinPower(powerBarStrength); //Set the spin speed.
      powerBarStrength = 105; //Reset powerBarStrength.
      fortuneWheel.setDrawPower(powerBarStrength);
      oneSpin = false;
    }
  }
}

void keyTyped() {
  if (boxSelected) {
    int input=0;
    if(key=='1') {
      input=1;
    }
    else if(key=='2') {
      input=2;
    }
    else if (key=='3') {
      input=3;
    }
    else if (key=='4') {
      input=4;
    }
    else if (key=='5') {
      input=5;
    }
    else if (key=='6') {
      input=6;
    }
    else if (key=='7') {
      input=7;
    }
    else if (key=='8') {
      input=8;
    }
    else if (key=='9') {
      input=9;
    }
    if(sudokuBoard.checkInput(input, box, puzzle.solved)) {
      puzzle.p[box/9][box%9]=input;
      points.increaseP(10);
      boxSelected=false;
    }
    else {
      errors.decreaseE();
      if(errors.returnErrors() == 0){
        gameState = 3;
      }
      //ERROR YOU FUCKING SUCK AT THIS GAME
    }
  }
}
      
      