//Project Yo //<>//
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
Button returnSudoku;
Button pencil;
Button mark;

SoundFile backgroundMusic;

void setup() {
  size(600, 450);
  background(#B87E3E);
  
  puzzle=new Puzzle();
  pencilIn=new PencilIn();
  points = new Points();
  errors = new Errors();
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
  B3 = new Button(200, 70, 90, 365, "Easy", #1CE86F, #1EBC5E, #1B7941, #FCFFFD);
  B4 = new Button(200, 70, 310, 365, "Hard", #D33526, #BF3023, #933128, #FCFFFD);
  wheelGame = new Button(100, 30, 475, 200, "", #458B86, #68AFB2, #156164, #C2CECE);
  quit = new Button(100, 30, 475, 400, "", #458B86, #68AFB2, #156164, #C2CECE);
  quit2 = new Button(100, 30, 475, 400, "", #458B86, #68AFB2, #156164, #C2CECE);
  quit3 = new Button(100,30,300,400,"",#458B86, #68AFB2, #156164, #C2CECE); 
  activateHint = new Button(100, 30, 475, 250, "", #458B86, #68AFB2, #156164, #C2CECE);
  returnSudoku = new Button(100, 30, 250, 400, "", #E56E1E, #863A07, #FC8608, #0F0F0E);
  pencil = new Button(100, 30, 475, 350, "", #458B86, #68AFB2, #156164, #C2CECE);
  mark = new Button(100, 30, 475, 300, "", #458B86, #68AFB2, #156164, #C2CECE);
  
  //backgroundMusic = new SoundFile(this, "background music.mp3");
  //backgroundMusic.loop();
}

void draw() {
  if (gameState == 0) //If we're in the menu.
  {
    menuBackground();
    B3.update();
    B4.update();
  } 
  else if (gameState == 1) //Sudoku Puzzle.
  {     
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
    formatButton("Mini Game", 480, 220); 
    
    activateHint.update();
    formatButton("Hint", 480, 270);

    mark.update();
    formatButton("Mark", 480, 320);

    pencil.update();
    formatButton("Pencil", 480, 370);

    quit.update();
    formatButton("Quit", 480, 420);

    Time.advance();
    textSize(20);
    fill(255);
    text(Time.convertToString(), 480, 100);

    textSize(16);
    fill(255);
    text("Score: " + points.returnPoints(), 460, 150);
    text("Errors: " + errors.returnErrors(), 460, 180);  
  } 
  else if (gameState == 2) {
    fortuneWheel.display();

    rectMode(CORNER);
    if (fortuneWheel.doneSpinning() && checkRewardOnce)
    {
      gambleReward = fortuneWheel.getReward();
      if(gambleReward == "TEAL"){
        points.doubleP();
      }
      else if(gambleReward == "MAGENTA"){
        points.tripleP();
      }
      else if(gambleReward == "ORANGE"){
        hintCost=50;
      }
      else if(gambleReward == "BLUE"){
        errors.increaseE();
      }
      else if(gambleReward == "RED"){
        points.halveP();
      }
      else if(gambleReward == "GREEN"){
        points.zero();
      }
      else if(gambleReward == "PURPLE"){
        hintCost=200;
      }
      else if(gambleReward == "LIME"){
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

    if (fortuneWheel.doneSpinning() && checkRewardOnce == false)
    {
      returnSudoku.isOver();
      returnSudoku.update();
      textSize(20);
      text("Return", 260, 425);
    }
  }
  else if (gameState == 3) {
    gameOverBackground();
    quit2.update();
    formatButton("Quit", 480, 420);
  }
  else if(gameState == 4){
    youWonBackground();
    quit3.update();
    formatButton("Return To Menu",300,410);
  }
}

void mouseClicked()
{
  if (gameState == 0) //Only occurs when in the Main Menu
  {
    puzzle.createSolved();
    gameState = 1; //Bring us to Sudoku.
    if (B3.over) //If mouse if over button
    {
      puzzle.easy();
      pencilIn.create(puzzle.p);
    } 
    else if (B4.over) //If mouse is over button
    {
      puzzle.hard();
      pencilIn.create(puzzle.p);
    } else
    {
      //Do Nothing
    }
  } 
  else if (gameState == 1) //If we're in Sudoku.
  {
    if (wheelGame.over) //If the mouse is over the button.
    {
      if (points.returnPoints()<50) {
        GWindow miniWindow;
        miniWindow = GWindow.getWindow(this, "", 860, 618, 300, 200, JAVA2D);
        miniWindow.addDrawHandler(this, "windowDraw");
        MyData data = new MyData();
        data.setOutput("Sorry, you must have\nat least 50 points to\nplay the mini game!");
        miniWindow.addData(data);
      }
      //else {
        gameState = 2; //Move Us to Mini Game State.
       // points.increaseP(-50);
      //}
    } 
    else if (activateHint.over) {
      if (points.returnPoints()<hintCost) {
         GWindow hintWindow;
         hintWindow = GWindow.getWindow(this, "", 860, 618, 300, 200, JAVA2D);
         hintWindow.addDrawHandler(this, "windowDraw");
         MyData data = new MyData();
         data.setOutput("Sorry, you haven't\nearned enough points\nto receive a hint yet!\nThe current cost for a\nhint is " + hintCost + " points.");
         hintWindow.addData(data);
      }
      else if (boxSelected) {
        Hints hint = new Hints(hintCost);
        puzzle.p[box/9][box%9]=hint.giveHint(box, puzzle.solved);
        points.increaseP(hintCost*(-1));
      }
      else {
        GWindow hintWindow;
        hintWindow = GWindow.getWindow(this, "", 860, 618, 300, 200, JAVA2D);
        hintWindow.addDrawHandler(this, "windowDraw");
        MyData data = new MyData();
        data.setOutput("Please select a cell\nfor your hint!");
        hintWindow.addData(data);
      }
    } 
    else if (quit.over) {
      resetGame();
      gameState = 0;
    } 
    else if (mark.over) {
      mode = 0;
      pencil.selected = false;
      mark.selected = true;
    } 
    else if (pencil.over) {
      mode = 1;
      mark.selected = false;
      pencil.selected = true;
    }
    else if (sudokuBoard.overSudokuBoard() == true) {
      box=sudokuBoard.boxNumber();
      if (puzzle.p[box/9][box%9]==0) {
        boxSelected=true;
        x=mouseX;
        y=mouseY;
      }
    } 
    else {
      boxSelected=false;
    }
  } 
  else if (gameState == 2)
  {
    if (returnSudoku.over)
    {
      gameState = 1;
      resetMiniGame();
    }
  } 
  else if (gameState == 3) {
    if (quit2.over) {
      gameState = 0;
      resetGame();
    }
  }
  else if(gameState == 4){
    if(quit2.over){
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
      }
      else if (sudokuBoard.checkInput(input, box, puzzle.solved)) {
        puzzle.p[box/9][box%9]=input;
        pencilIn.update(puzzle.p);
        points.increaseP(10);
        boxSelected=false;
        if(sudokuBoard.checkIfWon(puzzle.p,puzzle.solved) == true){
          gameState = 4; //<>//
        }
      } 
      else {
        errors.decreaseE();
        if(errors.totalErrors!=0) {
          GWindow errorWindow;
          errorWindow = GWindow.getWindow(this, "", 860, 618, 300, 200, JAVA2D);
          errorWindow.addDrawHandler(this, "windowDraw");
          MyData data = new MyData();
          data.setOutput("Sorry, that's not the\ncorrect number for\nthis cell.\nErrors remaining: "+errors.totalErrors);
          errorWindow.addData(data);
        }
        else {
          gameState=3;
        }
      }
    } 
    else if (mode==1) {
      pencilIn.modify(input, box);
    }
  }
}

void resetGame() {
  Time.reset();
  points.reset();
  errors.resetE();
  boxSelected=false;
  hintCost=100;
}

void resetMiniGame() {
  oneSpin = true;
  checkRewardOnce = true;
  fortuneWheel.resetValues();
}

void windowDraw(PApplet app, GWinData data){
  MyData myData = (MyData) data;
  app.background(255);
  app.strokeWeight(2);
  app.fill(0);
  app.textSize(25);
  app.text(myData.output, 10, 40);
}

void menuBackground() {
  background(#B87E3E);
  PImage image = loadImage("SudokuMainPic.jpg");
  image(image, width/4, height/8);
}

void gameBackground() {
  background(#B87E3E);
  PImage mainWoodBackground = loadImage("Bamboo Texture 2.jpg");
  image(mainWoodBackground, 0, 0);
}

void gameOverBackground() {
  background(0);
  PImage loseBackground = loadImage("youjustlost.jpg");
  image(loseBackground, 100, 25);
}

void youWonBackground() {
  background(0);
  PImage winBackground = loadImage("youwon.jpg");
  image(winBackground,0,0);
}

void sideMenu() {
  fill(0);
  noStroke();
  rectMode(CORNERS);
  rect(445, 0, 600, 600);
  PImage sideMenuBackground = loadImage("Side Menu Bamboo.jpg");
  image(sideMenuBackground, 450, -180);
}

void formatButton(String name, int px, int py) {
  textSize(14);
  fill(255);
  textAlign(LEFT);
  text(name, px, py);  
}