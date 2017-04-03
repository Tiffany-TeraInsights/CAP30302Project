class Timer {
  
  int currentTime = 0;
  int startTime = 0;
  boolean done = false;
  
  
 Timer(){
   startTime = millis();
   done = false;
 }
  
  
  void advance(){ //<>// //<>//
     currentTime = millis() - startTime; //<>//
    } //<>//
    //<>// //<>// //<>//
  int getCurrentTime(){
     return currentTime; 
  }
   
   int second() {
      return (getCurrentTime() / 1000) % 60;
    }
    int minute() {
      return (getCurrentTime() / (1000*60)) % 60;
    }
    int hour() {
      return (int)(getCurrentTime() / (1000*60*60)) % 24;
    }
    
  boolean check(){
     return done; 
  }
  
  float returnTime(){
     done = true;
     return currentTime/1000; 
  }
}