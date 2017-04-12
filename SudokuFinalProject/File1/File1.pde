//Project Yo
//Added change
/*
gameState is used to dictate what "page" of the game we are on.
0 is the Main Menu
1 is Sudoku Game
2 is Mini Game
*/
int gameState = 0;
String difficulty = "";
Button B3;
Button B4;
Board sudokuBoard;
Button wheelGame;
Timer Time;
Puzzle puzzle;
int[][] puzzleSolution;
int powerBarStrength = 105; //Beginning value for power bar.
minigame fortuneWheel = new minigame(90);
boolean oneSpin = true;

void setup(){
  size(600,600);
  background(#B87E3E);
  //frameRate = 1;
  Time = new Timer();
  puzzle=new Puzzle();
}

void draw(){
  
  if(gameState == 0) //If we're in the menu.
  {
    background(#B87E3E);
    
    //Background image stuff
    PImage image = loadImage("SudokuMainPic.jpg");
    image(image,width/4,height/8);
    
    //CREATE BUTTONS
    B3 = new Button(200,70,90,500,"Easy", #1CE86F, #1EBC5E, #1B7941, #FCFFFD);
    B4 = new Button(200,70,310,500,"Hard", #D33526, #BF3023, #933128, #FCFFFD);
    
    //Update buttons
    B3.isOver();
    B4.isOver();
    B3.update();
    B4.update();
    
    Time.advance();
    text(Time.hour() + ":" + Time.minute() + ":" + Time.second(), 100,100);
  }
  else if(gameState == 1) //Sudoku Puzzle.
  {
    //Keep background color the same.
    background(#B87E3E);
    
    // Realistic Bamboo Background.
    //Draw Sudoku Background
    PImage mainWoodBackground = loadImage("Bamboo Texture 2.jpg");
    image(mainWoodBackground, 0, 0);
    
    sudokuBoard = new Board(); //<>//
    sudokuBoard.drawBoard(); //<>//
    //<>//
    //Shadow of side menu
    fill(0); //<>//
    noStroke(); //<>//
    rectMode(CORNERS);
    rect(445, 0, 600, 600);
    
    //Draw Side Menu Background
    PImage sideMenuBackground = loadImage("Side Menu Bamboo.jpg");
    image(sideMenuBackground, 450, -180);
    
    rectMode(CORNER);
    wheelGame = new Button(100, 50, 475, 300, "Easy", #B4EBED, #68AFB2, #156164, #C2CECE);
    wheelGame.isOver();
    wheelGame.update();
    
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
    
    if(difficulty == "HARD") //If hard.
    {
      //Whatever Needs to Happen with Hard.
    }
    else if(difficulty == "EASY") //If Easy
    {
      //Whatever Needs to Happen with Easy.
    }
  }
  else if(gameState == 2)
  {
    fortuneWheel.display();
    if(fortuneWheel.doneSpinning())
    {
      println(fortuneWheel.getReward());
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
      gameState = 1; //Bring us to Sudoku.
      difficulty = "EASY"; //Update difficulty
    }
    else if(B4.over) //If mouse is over button
    {
      gameState = 1; //Bring us to Sudoku.
      difficulty = "HARD"; //Update difficulty.
    }
    else
    {
      //Do Nothing
    }
  }
  else if(gameState == 1) //If we're in Sudoku.
  {
    wheelGame.isOver();
    if(wheelGame.over) //If the mouse is over the button.
    {
      gameState = 2; //Move Us to Mini Game State.
    }
    
    if(sudokuBoard.overSudokuBoard() == true){
       sudokuBoard.drawCursor();
    }
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