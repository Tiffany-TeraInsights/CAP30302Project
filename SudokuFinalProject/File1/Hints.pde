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
  
  int giveHint(int box, int puzzle[][]) {
    return puzzle[box/9][box%9];
  }
}