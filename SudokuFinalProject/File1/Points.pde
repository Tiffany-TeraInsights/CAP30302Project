class Points {
  
  int totalPoints = 0;
  
  void increase(int value){
    totalPoints += value;
  }
  
  void double(){
    totalPoints *= 2; 
  }
  
  void triple(){
    totalPoints *= 3; 
  }
  
  void halve(){
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