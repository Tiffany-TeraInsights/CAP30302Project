class Timer {  //<>// //<>// //<>//

  int currentTime = 0;
  int startTime = 0;

  // create timer
  Timer() {
    startTime = millis();
  }
  
  //reset timer
  void reset() {
    startTime=millis();
  }
  
  //increase timer
  void advance() {
    currentTime = millis() - startTime;
  } 
  
  //return current timer amount
  int getCurrentTime() {
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
  
  //convert millis to string value (format it)
  String convertToString() {
    String hour, minute, second;
    if(Time.hour() < 10){
      hour = "0" + Time.hour(); 
    }
    else {
     hour = "" + Time.hour(); 
    }
    if(Time.minute() < 10){
      minute = "0" + Time.minute(); 
    }
    else {
      minute = "" + Time.minute(); 
    }
    if(Time.second() < 10){
      second = "0" + Time.second();
    }
    else {
     second = "" + Time.second(); 
    }
    return hour + ":" + minute + ":" + second;
  }
 
  //return the current time
  float returnTime() {
    return currentTime/1000;
  }
}