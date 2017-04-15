class Button {

  float bwidth;
  float bheight;
  float positionX;
  float positionY;
  color current, normal, pressed, outline, textColor;
  String buttonText;
  boolean over, clicked;
  boolean selected = false;


  void isOver() {
    if ((mouseX > (positionX) && mouseX < (bwidth + positionX)) && ((mouseY > (positionY)) && (mouseY < (bheight + positionY)))) {
      current = pressed;
      over = true;
    } else {
      current = normal;
      over = false;
    }
  }

  void update() {

    isOver();

    if (selected == true) {
      fill(current); //<>//
      stroke(#F70000); //<>//

      rect(positionX, positionY, bwidth, bheight); //<>//
      fill(textColor);
      stroke(textColor);
      textSize(40);
      text(buttonText, positionX + 55, positionY + 50);
    } else {

      fill(current);
      stroke(outline);

      rect(positionX, positionY, bwidth, bheight);
      fill(textColor);
      stroke(textColor);
      textSize(40);
      text(buttonText, positionX + 55, positionY + 50);
    }
  }


  Button(float bw, float bh, float posX, float posY, String tex, color n, color o, color p, color tc) {
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