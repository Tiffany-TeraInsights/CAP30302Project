class spinner
{
  int size;
  
  spinner(int uSize)
  {
    size = uSize;
  }

  //Display the Spinner.
  void display(float rotation)
  {
    noStroke();
    pushMatrix();
    translate(width/2, height/2);

    pushMatrix();
    rotate(radians(rotation));

    //Outside Circle
    fill(50);
    ellipse(0, 0, size + 11, size + 11);

    //Full circle
    fill(0);
    ellipse(0, 0, size, size);

    //Part One
    fill(0, 255, 0); //Green
    arc(0, 0, size, size, 0, PI/4);

    //Part Two
    fill(255, 0, 0); //Red
    arc(0, 0, size, size, PI/4, PI/2);

    //Part Three
    fill(0, 0, 255); //Blue
    arc(0, 0, size, size, PI/2, (3 * PI)/4);

    //Part Four
    fill(#FF8503); //oRANGE
    arc(0, 0, size, size, (3 * PI)/4, PI);

    //Part Five
    fill(#FC007A); //Magenta
    arc(0, 0, size, size, PI, (5 * PI)/4);

    //Part Six
    fill(#00E9FC); //Teal
    arc(0, 0, size, size, (5 * PI)/4, (3 * PI)/2);

    //Part Seven
    fill(#96FC00); //Lime
    arc(0, 0, size, size, (3 * PI)/2, (7 * PI)/4);

    //Part Eight
    fill(#9B00FC); //Purple
    arc(0, 0, size, size, (7 * PI)/4, 2 * PI);

    popMatrix(); //Revert Rotation.

    //Top Triangle
    fill(50);
    triangle(-10, -((size/2) + 5), 10, -((size/2) + 5), 0, -((size/2) - 10));

    popMatrix(); //Revert Translation.
  }
  
  //Returns a value to start spinning the spinner.
  int spin(float value)
  {
    return (int)(value * 1);
  }
}