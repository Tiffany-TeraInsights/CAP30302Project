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

int gameState = 0;
int difficulty;
int x;
int y;
int box;
boolean boxSelected=false;
Button B3;
Button B4;
String hour, minute, second;
Board sudokuBoard;
Button wheelGame;
Button quit;
Button quit2, quit3;
Button activateHint;
Timer Time;
Puzzle puzzle;
PencilIn pencilIn;
boolean inputMode = false;
Points points;
Errors errors;
Hints hints;
int powerBarStrength = 105; //Beginning value for power bar.
minigame fortuneWheel = new minigame(200);
boolean oneSpin = true;
boolean checkRewardOnce = true;
Button returnSudoku;
String gambleReward = "";
Button pencil;
Button mark;
int mode = 0;
SoundFile backgroundMusic;

void setup() {
  size(600, 450);
  background(#B87E3E);
  Time = new Timer();
  puzzle=new Puzzle();
  pencilIn=new PencilIn(puzzle.p);
  points = new Points();
  errors = new Errors();
   //CREATE BUTTONS
  B3 = new Button(200, 70, 90, 365, "Easy", #1CE86F, #1EBC5E, #1B7941, #FCFFFD);
  B4 = new Button(200, 70, 310, 365, "Hard", #D33526, #BF3023, #933128, #FCFFFD);
  wheelGame = new Button(100, 30, 475, 200, "", #458B86, #68AFB2, #156164, #C2CECE);
  activateHint = new Button(100, 30, 475, 250, "", #458B86, #68AFB2, #156164, #C2CECE);
  mark = new Button(100, 30, 475, 300, "", #458B86, #68AFB2, #156164, #C2CECE);
  pencil = new Button(100, 30, 475, 350, "", #458B86, #68AFB2, #156164, #C2CECE);
  quit = new Button(100, 30, 475, 400, "", #458B86, #68AFB2, #156164, #C2CECE);
  returnSudoku = new Button(100, 30, 250, 400, "", #E56E1E, #863A07, #FC8608, #0F0F0E);
  //backgroundMusic = new SoundFile(this, "background music.mp3");
  //backgroundMusic.loop();
}

void draw() {
  
  if (gameState == 0) //If we're in the menu.
  {
    background(#B87E3E);

    //Background image stuff
    PImage image = loadImage("SudokuMainPic.jpg");
    image(image, width/4, height/8);

   
    //Update buttons
    B3.update();
    B4.update();
  } 
  else if (gameState == 1) //Sudoku Puzzle.
  { 
    //Keep background color the same.
    background(#B87E3E);

    // Realistic Bamboo Background.
    //Draw Sudoku Background
    PImage mainWoodBackground = loadImage("Bamboo Texture 2.jpg");
    image(mainWoodBackground, 0, 0);

    sudokuBoard = new Board();
    sudokuBoard.drawBoard();
    sudokuBoard.showNumbers(puzzle.p);
    sudokuBoard.showPencil(pencilIn.pencil);
    if (boxSelected) {
      sudokuBoard.drawCursor(x, y);
    }

    //Shadow of side menu
    fill(0);
    noStroke();
    rectMode(CORNERS);
    rect(445, 0, 600, 600);

    //Draw Side Menu Background
    PImage sideMenuBackground = loadImage("Side Menu Bamboo.jpg");
    image(sideMenuBackground, 450, -180);

    rectMode(CORNER);

    wheelGame.isOver();
    wheelGame.update();
    textSize(14);
    fill(255);
    textAlign(LEFT);
    text("Mini Game", 480, 220);

   

    //activateHint
    activateHint.isOver();
    activateHint.update();
    textSize(14);
    fill(255);
    textAlign(LEFT);
    text("Hint", 480, 270);

    
    mark.isOver();
    mark.update();
    textSize(14);
    fill(255);
    textAlign(LEFT);
    text("Mark", 480, 320);

  
    pencil.isOver();
    pencil.update();
    textSize(14);
    fill(255);
    textAlign(LEFT);
    text("Pencil", 480, 370);

    //quit
    quit.isOver();

    quit.update();
    textSize(14);
    fill(255);
    textAlign(LEFT);
    text("Quit", 480, 420);

    Time.advance();
    textSize(20);
    fill(255);
    
    if(Time.hour() < 10){
      hour = "0" + Time.hour(); 
    }
    else if(Time.hour() >= 10){
     hour = "" + Time.hour(); 
    }
    
    if(Time.minute() < 10){
      minute = "0" + Time.minute(); 
    }
    else if(Time.minute() >= 10){
      minute = "" + Time.minute(); 
    }
    
    if(Time.second() < 10){
      second = "0" + Time.second();
    }
    else if(Time.second() >= 10){
     second = "" + Time.second(); 
    }
     
    text(hour + ":" + minute + ":" + second, 480, 100);


    //Score
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
        //halve hint cost
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
         //double hint cost
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
}

void mouseClicked()
{
  if (gameState == 0) //Only occurs when in the Main Menu
  {
    B3.isOver();
    B4.isOver();
    if (B3.over) //If mouse if over button
    {
      difficulty=0;
      puzzle.easy();
      gameState = 1; //Bring us to Sudoku.
    } else if (B4.over) //If mouse is over button
    {
      difficulty=1;
      puzzle.hard();
      gameState = 1; //Bring us to Sudoku.
    } else
    {
      //Do Nothing
    }
  } else if (gameState == 1) //If we're in Sudoku.
  {
    wheelGame.isOver();
    activateHint.isOver();
    quit.isOver();
    pencil.isOver();
    mark.isOver();
    if (wheelGame.over) //If the mouse is over the button.
    {
      gameState = 2; //Move Us to Mini Game State.
    } 
    else if (activateHint.over) {
      if (boxSelected) {
        Hints hint = new Hints(0);
        int insert=hint.giveHint(box, puzzle.solved);
        puzzle.p[box/9][box%9]=insert;
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
      setup();
      gameState = 0;
    } 
    else if (mark.over) {
      mode = 0;
      pencil.selected = false;
      mark.selected = true;
      println("mark");
    } 
    else if (pencil.over) {
      mode = 1;
      mark.selected = false;
      pencil.selected = true;
      println("pencil");
    }


    if (sudokuBoard.overSudokuBoard() == true) {
      box=sudokuBoard.boxNumber();
      if (puzzle.p[box/9][box%9]==0) {
        boxSelected=true;
        x=mouseX;
        y=mouseY;
      }
    } else {
      boxSelected=false;
    }
  } else if (gameState == 2)
  {
    returnSudoku.isOver();
    if (returnSudoku.over)
    {
      gameState = 1;

      //Reset all of minigame.
      oneSpin = true;
      checkRewardOnce = true;
      fortuneWheel.resetValues();
    }
  } else if (gameState == 3) {
    background(0);
    PImage loseBackground = loadImage("youjustlost.jpg");
    image(loseBackground, 100, 25);

    quit2 = new Button(100, 30, 475, 400, "", #458B86, #68AFB2, #156164, #C2CECE);
    quit2.isOver();

    quit2.update();
    textSize(14);
    fill(255);
    textAlign(LEFT);
    text("Quit", 480, 420);

    if (quit2.over) {
      System.out.println(Time.returnTime());
      gameState = 0;
    }
  }
  else if(gameState == 4){
   background(0);
   PImage winBackground = loadImage("youwon.jpg");
   image(winBackground,0,0);
   
   quit3 = new Button(100,30,300,400,"",#458B86, #68AFB2, #156164, #C2CECE); 
   quit3.update();
   
   textSize(14);
   fill(255);
   textAlign(LEFT);
   text("Return To Menu",300,410);
   
   if(quit2.over){
     gameState = 0; 
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
  if (gameState == 1) {
    /* if(inputMode && m[rowNum][colNum] == 0 && key>='0' && key<='9') {
     m[rowNum][colNum] = key - '0'; // '0'
     inputMode = false;
     } */
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
      if (sudokuBoard.checkInput(input, box, puzzle.solved)) {
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
        GWindow errorWindow;
        errorWindow = GWindow.getWindow(this, "", 860, 618, 300, 200, JAVA2D);
        errorWindow.addDrawHandler(this, "windowDraw");
        MyData data = new MyData();
        data.setOutput("Sorry, that's not the\ncorrect number for\nthis cell.\nErrors remaining: "+errors.totalErrors);
        errorWindow.addData(data);
      }
      if (errors.returnErrors() == 0) {
        gameState = 3;
      }
    } else if (mode==1) {
      pencilIn.modify(input, box);
    }
  }
}

void windowDraw(PApplet app, GWinData data){
  MyData myData = (MyData) data;
  app.background(255);
  app.strokeWeight(2);
  app.fill(0);
  app.textSize(27);
  app.text(myData.output, 10, 40);
}