class Button{
   
  float bwidth;
  float bheight;
  float positionX;
  float positionY;
  color current, normal, pressed, outline, textColor = 255;
  String buttonText;
  boolean over,clicked;


  void isOver(){
    if(mouseX > (positionX) && mouseX < (bwidth + positionX)){
       if((mouseY > (positionY)) && (mouseY < (bheight + positionY))){ 
          current = pressed;
          over = true;
       }
    }
    else{
       current = normal;
       over = false;
    }
  }
  
  void update(){
    
    fill(current);
    stroke(outline);
    
    rect(positionX, positionY, bwidth, bheight);
    fill(textColor);
    stroke(textColor);
    textSize(40);
    text(buttonText,positionX + 55, positionY + 50);
    
    isOver();
    
  }

  Button(float bw, float bh, float posX, float posY, String tex, color n, color o, color p, color tc){
    bwidth = bw;
    bheight = bh;
    positionX = posX;
    positionY = posY;
    buttonText = tex;
    normal = n;
    outline = o;
    pressed = p;
    textColor = tc;
  }
}