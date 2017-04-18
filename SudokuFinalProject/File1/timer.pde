class Timer {  //<>//

  int currentTime = 0;
  int startTime = 0;


  Timer() {
    startTime = millis();
  }

  void reset() {
    startTime=millis();
  }
  
  void advance() {
    currentTime = millis() - startTime;
  } 
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

  float returnTime() {
    return currentTime/1000;
  }
}