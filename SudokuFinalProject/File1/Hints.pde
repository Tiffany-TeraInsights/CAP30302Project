class Hints {
  
  int hintCost;
  
  int returnHintCost(){
    return hintCost;
  }
  
  void changeHintCost(float multiplier){
   hintCost *= multiplier; 
  }
  

  Hints(int initialCost){
    hintCost = initialCost;
  }
  
}