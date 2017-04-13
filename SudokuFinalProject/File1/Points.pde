class Points {
  
  int totalPoints = 0;
  
  void increaseP(int value){
    totalPoints += value;
  }
  
  void doubleP(){
    totalPoints *= 2; 
  }
  
  void tripleP(){
    totalPoints *= 3; 
  }
  
  void halveP(){
    totalPoints = (int)(totalPoints/2);
  }
  
  void zero(){
    totalPoints = 0; 
  }
  
  int returnPoints(){
    return totalPoints; 
  }
  
  Points(){
    
  }

  
}