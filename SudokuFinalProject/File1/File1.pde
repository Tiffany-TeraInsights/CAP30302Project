//Project Yo

boolean inMenu = true;
String difficulty = "";
Button B3;
Button B4;
Timer Time;

void setup(){
  size(600,600);
  background(#B87E3E);
  //frameRate = 1;
  Time = new Timer();
}

void draw(){
  
  if(inMenu)
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
  else //No longer in menu.
  {
    //Keep background color the same.
    background(#B87E3E);
    
    if(difficulty == "HARD") //If hard.
    {
      text(difficulty, 300, 300);
    }
    else if(difficulty == "EASY") //If Easy
    {
      text(difficulty, 300, 300);
    }
  }
}

void mouseClicked()
{
  if(inMenu)
  {
    B3.isOver();
    B4.isOver();
    if(B3.over) //If mouse if over button
    {
      inMenu = false; //Take us out of menu.
      difficulty = "EASY"; //Update difficulty
    }
    else if(B4.over) //If mouse is over button
    {
      inMenu = false; //Take us out menu.
      difficulty = "HARD"; //Update difficulty.
    }
    else
    {
      //Do Nothing
    }
  }
  else
  {
    //Do Nothing
  }
}