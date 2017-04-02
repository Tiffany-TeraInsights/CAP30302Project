//Project Yo

void setup(){
  size(600,600);
  background(#B87E3E);
}

void draw(){
  PImage image = loadImage("SudokuMainPic.jpg");
  image(image,width/4,height/8);
}