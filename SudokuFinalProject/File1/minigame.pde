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
    PImage miniGameBackground = loadImage("lasvegas.jpg");
    image(miniGameBackground, 0, 0);
    
    PImage lasVegasSign = loadImage("lvsign.png");
    image(lasVegasSign,400,10,200,200);
    
    fill(#F7F7F7,150);
    rect(10,50,170,300);
    
    textSize(10);
    fill(255,0,0);
    rect(20,70,10,10);
    fill(0);
    text(" - Halve Your Points",30,79);
    fill(0,255,0);
    rect(20,100,10,10);
    fill(0);
    text(" - Lose All Points",30,109);
    fill(0,0,255);
    rect(20,130,10,10);
    fill(0);
    text(" + Increase Errors Left By 1 ",30,139);
    fill(#FF8503);
    rect(20,160,10,10);
    fill(0);
    text(" + Hint Cost Reduced By Half ",30,169);
    fill(#FC007A);
    rect(20,190,10,10);
    fill(0);
    text(" + Triple Points",30,199);
    fill(#00E9FC);
    rect(20,220,10,10);
    fill(0);
    text(" + Double Points",30,229);
    fill(#96FC00); 
    rect(20,250,10,10);
    fill(0);
    text(" - Set Errors Left To 1",30,259);
    fill(#9B00FC);
    rect(20,280,10,10);
    fill(0);
    text(" - Double Hint Cost",30,289);
    
    text(" + : Gain      - : Loss",30,330);
    
    fill(255,150);
    rect(200,380,200,30);
    fill(0);
    text("Hold down w to increase spin power!",210,395);
    
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
    rect(100, height - 50, width - 100, height - 5);
    
    //Inside of power bar.
    fill(0, 150, 0);
    rectMode(CORNERS);
    rect(105, height - 45, drawPower, height - 10);
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