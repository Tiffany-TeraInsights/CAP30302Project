class Points {
  // class to keep track of total points
  int totalPoints = 0;
  
  //reset points
  void reset() {
    totalPoints=0;
  }
  
  //increase point value
  void increaseP(int value){
    totalPoints += value;
  }
  
  //double point values
  void doubleP(){
    totalPoints *= 2; 
  }
  
  //triple point values
  void tripleP(){
    totalPoints *= 3; 
  }
  
  //halve the amount of points
  void halveP(){
    totalPoints = (int)(totalPoints/2);
  }
  
  //zero out points
  void zero(){
    totalPoints = 0; 
  }
  
  int returnPoints(){
    return totalPoints; 
  }
  
  Points(){
    
  }

  
}