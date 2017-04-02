//Project Yo

void setup(){
  size(600,600);
  background(#B87E3E);
}

void draw(){
  PImage image = loadImage("SudokuMainPic.jpg");
  image(image,width/4,height/8);
  
  Button B3 = new Button(200,70,100,250,"Easy",#1CE86F,#1EBC5E,#1B7941,#FCFFFD);
  Button B4 = new Button(200,70,290,250,"Hard",#D33526, #BF3023, #933128, #FCFFFD);
  
  B3.isOver();
  B4.isOver();
  B3.update();
  B4.update();
}