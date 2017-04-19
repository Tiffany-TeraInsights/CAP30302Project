//Project Yo //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
//Added change
/*
gameState is used to dictate what "page" of the game we are on.
 0 is the Main Menu
 1 is Sudoku Game
 2 is Mini Game
 */

import processing.sound.*;
import g4p_controls.*;

Puzzle puzzle;
PencilIn pencilIn;
Points points;
Errors errors;
Hints hint;
HighScores hs = new HighScores();
int gameState;
int mode;
int hintCost;

Board sudokuBoard;
int x;
int y;
int box;
boolean boxSelected;



Timer Time;
String hour, minute, second;

minigame fortuneWheel;
int powerBarStrength;
boolean oneSpin;
boolean checkRewardOnce;
String gambleReward;

Button B3;
Button B4;
Button wheelGame;
Button quit, quit2, quit3;
Button activateHint;
Button autoHint;
Button returnSudoku;
Button pencil;
Button mark;

SoundFile backgroundMusic;
SoundFile clickSound;
PFont highScoreFont;
PFont normalFont;

PImage zenCircle;

void setup() {
  size(600, 450);
  background(#B87E3E);

  puzzle=new Puzzle();
  pencilIn=new PencilIn();
  points = new Points();
  errors = new Errors();
  hint = new Hints(100);
  gameState=0;
  mode=0;
  hintCost=100;

  sudokuBoard = new Board();
  boxSelected=false;

  Time = new Timer();

  fortuneWheel = new minigame(200);
  powerBarStrength = 105; //Beginning value for power bar.
  oneSpin = true;
  checkRewardOnce = true;
  gambleReward = "";

  //CREATE BUTTONS
  color returnInside = color(#F7F7F7, 150);
  B3 = new Button(200, 70, 90, 365, "Easy", returnInside, 0, #F7F7F7, #0F0F0E);
  B4 = new Button(200, 70, 310, 365, "Hard", returnInside, 0, #F7F7F7, #0F0F0E);
  wheelGame = new Button(100, 30, 475, 180, "", #458B86, #68AFB2, #156164, #C2CECE);
  quit = new Button(100, 30, 475, 400, "", #458B86, #68AFB2, #156164, #C2CECE);
  quit2 = new Button(100, 30, 475, 400, "", #458B86, #68AFB2, #156164, #C2CECE);
  quit3 = new Button(150, 30, 230, 400, "", #458B86, #68AFB2, #156164, #C2CECE); 
  activateHint = new Button(60, 30, 465, 250, "", #458B86, #68AFB2, #156164, #C2CECE);
  autoHint = new Button(60, 30, 530, 250, "", #458B86, #68AFB2, #156164, #C2CECE);
  returnSudoku = new Button(100, 30, 250, 400, "", #E56E1E, #863A07, #FC8608, #0F0F0E);
  //activateHint = new Button(100, 30, 475, 250, "", #458B86, #68AFB2, #156164, #C2CECE);
  returnSudoku = new Button(100, 30, 250, 340, "", returnInside, 0, #F7F7F7, #0F0F0E);
  pencil = new Button(100, 30, 475, 350, "", #458B86, #68AFB2, #156164, #C2CECE);
  mark = new Button(100, 30, 475, 300, "", #458B86, #68AFB2, #156164, #C2CECE);

  //Get sound files and begin playing backgroundMusic.
  clickSound = new SoundFile(this, "ClickSound.mp3");
  backgroundMusic = new SoundFile(this, "background music.mp3");
  backgroundMusic.loop();
  
  //Get those fonts.
  highScoreFont = loadFont("BrushScriptMT-48.vlw");
  normalFont = loadFont("LucidaSans-48.vlw");
  
  //Necessary image.
  zenCircle = loadImage("ZenCircleUse.png");
}

void draw() {
  if (gameState == 0) //If we're in the menu.
  {
    /*
     * Elegantly displays the Start Menu in a Zen style
     * Displays the current highscore and the buttons to choose between 
     * Easy and Hard.
     */
    menuBackground();
    textFont(highScoreFont);
    textSize(20);
    textAlign(CENTER);
    image(zenCircle, 222, 190);
    text("Best Score:", 300, 260);
    text(hs.returnHighScores(), 295, 285);
    textFont(normalFont);
    textAlign(LEFT);
    B3.update();
    B4.update();
  } else if (gameState == 1) //Sudoku Puzzle.
  {     

    checkIfDone();
    
    gameBackground();
    sudokuBoard.drawBoard();
    sudokuBoard.showNumbers(puzzle.p);
    sudokuBoard.showPencil(pencilIn.pencil);
    if (boxSelected) {
      sudokuBoard.drawCursor(x, y);
    }
    sideMenu();

    rectMode(CORNER);
    wheelGame.update();
    formatButton("Mini Game", 480, 200); 

    activateHint.update();
    formatButton("Pick", 480, 270);

    autoHint.update();
    formatButton("Auto", 544, 270);

    mark.update();
    formatButton("Mark", 480, 320);

    pencil.update();
    formatButton("Pencil", 480, 370);

    quit.update();
    formatButton("Quit", 480, 420);

    Time.advance();
    textSize(20);
    fill(255);
    text(Time.convertToString(), 480, 80);

    textSize(16);
    fill(255);
    text("Score: " + points.returnPoints(), 460, 110);
    text("Errors: " + errors.returnErrors(), 460, 140);  
    text("Game Cost: " + 50, 467, 170);
    text("Hint Cost: " + hint.returnHintCost(), 470, 240);
    
  } else if (gameState == 2) { //In the Minigame.
  
    //Displays the Las Vegas themed minigame.
    fortuneWheel.display();

    rectMode(CORNER);
    
    //If we've spun, have finished spinning, and have yet to check for a reward.
    if (fortuneWheel.doneSpinning() && checkRewardOnce)
    {
      //Gathers the reward and turns it into something substantial based on the color
      //the wheel landed on.
      gambleReward = fortuneWheel.getReward();
      if (gambleReward == "TEAL") {
        points.doubleP();
      } else if (gambleReward == "MAGENTA") {
        points.tripleP();
      } else if (gambleReward == "ORANGE") {
        hintCost=50;
      } else if (gambleReward == "BLUE") {
        errors.increaseE();
      } else if (gambleReward == "RED") {
        points.halveP();
      } else if (gambleReward == "GREEN") {
        points.zero();
      } else if (gambleReward == "PURPLE") {
        hintCost=200;
      } else if (gambleReward == "LIME") {
        errors.setToOne();
      }
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

    //After we've spun and gathered our reward, display a button to return us to Sudoku.
    if (fortuneWheel.doneSpinning() && checkRewardOnce == false)
    {
      returnSudoku.isOver();
      returnSudoku.update();
      textSize(20);
      text("Return", 267, 363);
    }
    
    //If we've run out of errors display a losing screen and a quit button.
  } else if (gameState == 3) {
    gameOverBackground();
    quit2.update();
    formatButton("Quit", 480, 420);
    
    //If we've won, display a winning screen and a "Return to Menu" button.
  } else if (gameState == 4) {
    youWonBackground();
    quit3.update();
    formatButton("Return To Menu", 250, 420);
  }
}

//Checks if the puzzle is complete.
void checkIfDone(){
     int count = 0;
    for (int i = 0; i < 9; ++i) {
      for (int j = 0; j < 9; ++j) {
        if (puzzle.p[i][j] == puzzle.solved[i][j]) {
          count++;
        }
      }
    }
    
    if(count == 81){
      hs.addHighScore(Time.getCurrentTime());
      gameState = 4; 
    } 
}

void mouseClicked()
{
  //Play a clicking sound.
  clickSound.play();
  if (gameState == 0) //Only occurs when in the Main Menu
  {
    puzzle.createSolved();

    if (B3.over) //If mouse if over Easy button
    {
      //Create easy puzzle.
      puzzle.easy();
      pencilIn.create(puzzle.p);
      gameState = 1; //Bring us to Sudoku.
    } else if (B4.over) //If mouse is over Hard button
    {
      //Create hard puzzle.
      puzzle.hard();
      pencilIn.create(puzzle.p);
      gameState = 1; //Bring us to Sudoku.
    } else
    {
      //Do Nothing
    }
  } else if (gameState == 1) //If we're in Sudoku.
  {
    //<>// //<>//
    if (wheelGame.over) //If the mouse is over the minigame button.
    {
      //If we don't have enough points, display a window letting us know.
      if (points.returnPoints()<50) {
        GWindow miniWindow;
        miniWindow = GWindow.getWindow(this, "", 860, 618, 300, 200, JAVA2D);
        miniWindow.addDrawHandler(this, "windowDraw");
        MyData data = new MyData();
        data.setOutput("Sorry, you must have\nat least 50 points to\nplay the mini game!");
        miniWindow.addData(data);
      } else {
        //Otherwise, subtract out points and move us to the minigame!
        gameState = 2; //Move Us to Mini Game State.
        points.increaseP(-50);
      }
      //If we're over the "Pick" hint button.
    } else if (activateHint.over) { //<>//
      //If we don't have enough points for a hint, display a window letting us know.
      if (points.returnPoints()<hintCost) { //<>// //<>// //<>//
        GWindow hintWindow;
        hintWindow = GWindow.getWindow(this, "", 860, 618, 300, 200, JAVA2D);
        hintWindow.addDrawHandler(this, "windowDraw");
        MyData data = new MyData();
        data.setOutput("Sorry, you haven't\nearned enough points\nto receive a hint yet!\nThe current cost for a\nhint is " + hintCost + " points.");
        hintWindow.addData(data);
      } else if (boxSelected) {
        //If we do have enough points, give us a hint and subtract from out points.
        puzzle.p[box/9][box%9]=hint.giveHint(box, puzzle.solved);
        points.increaseP(hintCost*(-1));
      } else {
        //If we ask for a hint without having a box selected, remind us with instructions.
        GWindow hintWindow;
        hintWindow = GWindow.getWindow(this, "", 860, 618, 300, 200, JAVA2D);
        hintWindow.addDrawHandler(this, "windowDraw");
        MyData data = new MyData();
        data.setOutput("Please select a cell\nfor your hint!");
        hintWindow.addData(data);
      }
    } else if (autoHint.over) {
      //If we clicked on the "auto" hint button
      
      //If we don't have enough points, remind us the cost of the points with a well placed window.
      if (points.returnPoints()<hintCost) { //<>// //<>//
       GWindow hintWindow;
       hintWindow = GWindow.getWindow(this, "", 860, 618, 300, 200, JAVA2D);
       hintWindow.addDrawHandler(this, "windowDraw");
       MyData data = new MyData();
       data.setOutput("Sorry, you haven't\nearned enough points\nto receive a hint yet!\nThe current cost for a\nhint is " + hintCost + " points.");
       hintWindow.addData(data);
       }
       else{ 
         //If we have enough points, GIVE. US. THAT. HINT. YEAH! and charge us points of course.
      puzzle.p = hint.getHint(puzzle.p, puzzle.solved);
      if (puzzle.p == puzzle.solved) {
        System.out.println("Solved");
      } else {
        System.out.println("Not Solved");
      }
      points.increaseP(hintCost*(-1));
       }
    } else if (quit.over) {
      //If the quit button is clicked, display the start menu and reset everything.
      resetGame();
      gameState = 0;
    } else if (mark.over) {
      //If the mark button is clicked, set the mode to "mark" and off of "Pencil".
      mode = 0;
      pencil.selected = false;
      mark.selected = true;
    } else if (pencil.over) {
      //If the pencil button is clicked, set the mode to "pencil" and off of "mark".
      mode = 1;
      mark.selected = false;
      pencil.selected = true;
    } else if (sudokuBoard.overSudokuBoard() == true) {
      box=sudokuBoard.boxNumber();
      if (puzzle.p[box/9][box%9]==0) {
        boxSelected=true;
        x=mouseX;
        y=mouseY;
      }
    } else {
      boxSelected=false;
    }
  } else if (gameState == 2) //Only in minigame.
  {
    if (returnSudoku.over)
    {
      //If the return button is clicked, reset minigame and display the sudoku frame.
      gameState = 1;
      resetMiniGame();
    }
  } else if (gameState == 3) { //Only in lose screen.
    if (quit2.over) {
      //If the quit button is clicked, reset the whole game and return to the start menu.
      gameState = 0;
      resetGame();
    }
  } else if (gameState == 4) { //Only in the win screen.
    if (quit3.over) {
      //If the quit button is clicked, reset the whole game and return to the start menu.
      gameState = 0; 
      resetGame();
    }
  }
}

void keyPressed()
{
  //Only do the following if we're inside the minigame.
  if (gameState == 2) 
  {
    //Increasing powerbar and updating it for the Minigame.
    if (key == 'w' && oneSpin) //If the key pressed is W.
    {
      if (powerBarStrength < 495) //And We haven't hit maximum.
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
  if (gameState == 2)
  {
    if (key == 'w' && oneSpin) //If the key was "w" meaning we were charging the powerbar.
    {
      fortuneWheel.setSpinPower(powerBarStrength); //Set the spin speed.
      powerBarStrength = 105; //Reset powerBarStrength.
      fortuneWheel.setDrawPower(powerBarStrength);
      oneSpin = false;
    }
  }
}

void keyTyped() {
  /*
   * Only if a box is selected do we get the correct input and only accept numbers.
   */
  if (boxSelected) {
    int input=0;
    if (key=='1') {
      input=1;
    } else if (key=='2') {
      input=2;
    } else if (key=='3') {
      input=3;
    } else if (key=='4') {
      input=4;
    } else if (key=='5') {
      input=5;
    } else if (key=='6') {
      input=6;
    } else if (key=='7') {
      input=7;
    } else if (key=='8') {
      input=8;
    } else if (key=='9') {
      input=9;
    }

    if (mode==0) {
      if (input==0) {
        GWindow invalidInputWindow;
        invalidInputWindow = GWindow.getWindow(this, "", 860, 618, 300, 200, JAVA2D);
        invalidInputWindow.addDrawHandler(this, "windowDraw");
        MyData data = new MyData();
        data.setOutput("Please enter only\nnumbers 1 through 9.");
        invalidInputWindow.addData(data);
      } else if (sudokuBoard.checkInput(input, box, puzzle.solved)) {
        puzzle.p[box/9][box%9]=input;
        pencilIn.update(puzzle.p);
        points.increaseP(10);
        boxSelected=false;
        if (sudokuBoard.checkIfWon(puzzle.p, puzzle.solved) == true) {
          gameState = 4;
        }
      } else {
        errors.decreaseE();
        if (errors.totalErrors!=0) {
          GWindow errorWindow;
          errorWindow = GWindow.getWindow(this, "", 860, 618, 300, 200, JAVA2D);
          errorWindow.addDrawHandler(this, "windowDraw");
          MyData data = new MyData();
          data.setOutput("Sorry, that's not the\ncorrect number for\nthis cell.\nErrors remaining: "+errors.totalErrors);
          errorWindow.addData(data);
        } else {
          gameState=3;
        }
      }
    } else if (mode==1) {
      pencilIn.modify(input, box);
    }
  }
}

//Reset everything.
void resetGame() {
  Time.reset();
  points.reset();
  errors.resetE();
  boxSelected=false;
  hintCost=100;
}

//Reset the minigame.
void resetMiniGame() {
  oneSpin = true;
  checkRewardOnce = true;
  fortuneWheel.resetValues();
}

//For the windows
void windowDraw(PApplet app, GWinData data) {
  MyData myData = (MyData) data;
  app.background(255);
  app.strokeWeight(2);
  app.fill(0);
  app.textSize(25);
  app.text(myData.output, 10, 40);
}

//Menu background display.
void menuBackground() {
  background(#B87E3E);
  PImage startBackground = loadImage("ZenGarden1.jpg");
  PImage image = loadImage("SudokuTitle4.png");
  image(startBackground, -200, -115);
  image(image, width/4, height/4);
}

//Game background display.
void gameBackground() {
  background(#B87E3E);
  PImage mainWoodBackground = loadImage("SudokuSideMenu.jpg");
  image(mainWoodBackground, 0, 0);
}

//Game over display.
void gameOverBackground() {
  background(0);
  PImage loseBackground = loadImage("youjustlost.jpg");
  image(loseBackground, 100, 25);
}

//Game win display.
void youWonBackground() {
  background(0);
  PImage winBackground = loadImage("youwin.png");
  image(winBackground, 150,25,300,300);
}

//Side Menu display.
void sideMenu() {
  fill(0);
  noStroke();
  rectMode(CORNERS);
  rect(445, 0, 600, 600);
  PImage sideMenuBackground = loadImage("Side Menu Bamboo.jpg");
  image(sideMenuBackground, 450, -180);
}

//Format buttons.
void formatButton(String name, int px, int py) {
  textSize(14);
  fill(255);
  textAlign(LEFT);
  text(name, px, py);
}