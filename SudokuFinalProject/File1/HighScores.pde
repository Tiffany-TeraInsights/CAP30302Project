class HighScores {
  
  float list[];
  String readableList[];
  
  void addHighScore(float time){
    append(list,time);
  }
  
  int seconds(float currentTime) {
    return (int)(currentTime/ 1000) % 60;
  }
  int minutes(float currentTime) {
    return (int)(currentTime / (1000*60)) % 60;
  }
  int hours(float currentTime) {
    return (int)(currentTime / (1000*60*60)) % 24;
  }
 
  String convertToString(float time) {
    String hour, minute, second;
    if(hours(time) < 10){
      hour = "0" + hours(time); 
    }
    else {
     hour = "" + hours(time); 
    }
    if(minutes(time) < 10){
      minute = "0" + minutes(time); 
    }
    else {
      minute = "" + minutes(time); 
    }
    if(seconds(time) < 10){
      second = "0" + seconds(time);
    }
    else {
     second = "" + seconds(time); 
    }
    return hour + ":" + minute + ":" + second;
  }
  
  String[] returnHighScores(){
 
    for(int i = 0; i < list.length; ++i){
      append(readableList, convertToString(list[i]));
    }
    return readableList;
  }
  
 
  HighScores(){
    
  }
  
}