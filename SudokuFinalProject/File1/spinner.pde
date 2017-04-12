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
    rotate(degrees(rotation));
    
    //Outside Circle
    fill(50);
    ellipse(0, 0, size + 11, size + 11);
    
    //Full circle
    fill(255, 0, 255);
    ellipse(0, 0, size, size);
    
    //Part One
    fill(0, 255, 0);
    arc(0, 0, size, size, 0, PI/2);
    
    //Part Two
    fill(255, 0, 0);
    arc(0, 0, size, size, PI/2, PI);
    
    //Part Three
    fill(0, 0, 255);
    arc(0, 0, size, size, PI, (3 * PI)/2);
    
    //Part Four
    fill(0, 255, 255);
    arc(0, 0, size, size, (3 * PI)/2, 2 * PI);
    
    popMatrix(); //Revert Rotation.
    
    //Top Triangle
    fill(50);
    triangle(-10, -((size/2) + 5), 10, -((size/2) + 5), 0, -((size/2) - 10));
    
    popMatrix(); //Revert Translation.
  }
  
  //Decides the reward value based on where the spinner landed.
  int decideReward()
  {
    return 4;
  }
  
  //Returns a value to beginning spinning the spinner.
  int spin(float value)
  {
    return (int)value * 20;
  }
}