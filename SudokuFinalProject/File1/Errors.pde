class Errors {
  
  int totalErrors = 3;
  
  void increaseE(){
    totalErrors += 1;
  }
  
  void decreaseE(){
    totalErrors -= 1;
  }
  
  int returnErrors(){
    return totalErrors;
  }
  
 
  Errors(){
    
  }
  
}