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

Button wheelGame;
Timer Time;
int powerBarStrength = 105; //Beginning value for power bar.
minigame fortuneWheel = new minigame(90);
boolean oneSpin = true;
boolean checkRewardOnce = true;
Button returnSudoku;
String gambleReward = "";

void setup(){
  size(600,600);
  background(#B87E3E);
  //frameRate = 1;
  Time = new Timer();
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
    
    //Shadow of side menu
    fill(0);
    noStroke();
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
    
    rectMode(CORNER);
    returnSudoku = new Button(100, 50, 250, 400, "Return", #E56E1E, #863A07, #FC8608, #0F0F0E);
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