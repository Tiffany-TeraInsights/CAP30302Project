class minigame
{
  int colorArray[] = {#EA1818, #EAE418, #DF18EA, #1851EA, #1AEA18};
  spinner wheel;
  int drawPower = 105; //Used for drawing the bar.
  float spinPower = 0; //Used for beginning the spin.
  boolean activeSpin = false;
  
  minigame(int size)
  {
    wheel = new spinner(size);
  }
  
  //Returns the name of the color the spinner landed on so "File1" can decide what that means.
  String getReward()
  {
    float rewardNum = spinPower;
    String reward = "";
    if(rewardNum <= PI / 4)
    {
      reward = "TEAL";
    }
    else if(rewardNum <= PI / 2)
    {
      reward = "MAGENTA";
    }
    else if(rewardNum <= (3 * PI)/4)
    {
      reward = "ORANGE";
    }
    else if(rewardNum <= PI)
    {
      reward = "BLUE";
    }
    else if(rewardNum <= (5 * PI)/4)
    {
      reward = "RED";
    }
    else if(rewardNum <= (3 * PI)/2)
    {
      reward = "GREEN";
    }
    else if(rewardNum <= (7 * PI)/4)
    {
      reward = "PURPLE";
    }
    else if(rewardNum <= 2 * PI)
    {
      reward = "LIME";
    }
    return reward;
  }
  
  //Displays the whole jam. 
  void display()
  {
    //Display a Carnival Background.
    for(int i = 0; i < 5; i++)
    {
      fill(colorArray[i]);
      rect(i * 120, 0, (i * 120) + 120, height);
    }
    
    //Display the wheel with the update rotation value.
     wheel.display(radians(spinPower));
     
     //If the wheel is currently spinning.
     if(activeSpin && spinPower >= radians(360))
     {
       //Reduce the value of the rotation and spin.
       spinPower = spinPower - 7.767566767534232;
     }
     else if(activeSpin && spinPower < radians(360)) //If the wheel is done spinning
     {
       //Stop updating spinPower as we are done.
     }
    
    //Outline of powerbar.
    fill(150);
    rectMode(CORNERS);
    rect(100, height - 100, width - 100, height - 50);
    
    //Inside of power bar.
    fill(0, 150, 0);
    rectMode(CORNERS);
    rect(105, height - 95, drawPower, height - 55);
  }
  
  //Sets the drawPower to we can update the power bar.
  //drawPower is not used in actual calculations.
  void setDrawPower(int newPower) 
  {
    drawPower = newPower;
  }
  
  //Sets the spin power and activates our spinning.
  void setSpinPower(int power)
  {
    spinPower = wheel.spin(power);
    activeSpin = true;
  }
  
  //Returns spin power so "File1" can know when we have finished spinning.
  float getSpinPower()
  {
    return spinPower;
  }
  
  boolean doneSpinning()
  {
    if(activeSpin && spinPower < radians(360))
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  void resetValues()
  {
    spinPower = 0;
    activeSpin = false;
  }
}