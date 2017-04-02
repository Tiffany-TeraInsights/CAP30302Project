//Project Yo

boolean inMenu = true;
String difficulty = "";
Button B3;
Button B4;

void setup(){
  size(600,600);
  background(#B87E3E);
}

void draw(){
  
  if(inMenu)
  {
    PImage image = loadImage("SudokuMainPic.jpg");
    image(image,width/4,height/8);
    
    B3 = new Button(200,70,100,500,"Easy", #1CE86F, #1EBC5E, #1B7941, #FCFFFD);
    B4 = new Button(200,70,290,500,"Hard", #D33526, #BF3023, #933128, #FCFFFD);
    
    B3.isOver();
    B4.isOver();
    B3.update();
    B4.update();
  }
}

void mouseClicked()
{
  if(inMenu)
  {
    B3.isOver();
    B4.isOver();
    if(B3.over)
    {
      inMenu = false;
      difficulty = "EASY";
    }
    else if(B4.over)
    {
      inMenu = false;
      difficulty = "HARD";
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