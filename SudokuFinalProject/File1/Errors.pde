class Errors {
  
  // class to track error amounts
  int totalErrors = 3;
  
  //reset errors
  void resetE() {
    totalErrors=3;
  }
  
  //increase error count
  void increaseE(){
    totalErrors += 1;
  }
  
  //decrease error count
  void decreaseE(){
    totalErrors -= 1;
  }
  
  //set errors to 1
  void setToOne(){
    totalErrors = 1; 
  }
  
  // return amount of errors
  int returnErrors(){
    return totalErrors;
  }
  
 
  Errors(){
    
  }
  
}