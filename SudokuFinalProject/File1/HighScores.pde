class HighScores {
  
  float list[];
  float[] readableList;
  
  //add a high score to the list //<>//
  void addHighScore(float time){ //<>// //<>//
    int i = 0; //<>// //<>//
    while (readableList[i] != 0){ //<>// //<>//
     ++i;  //<>// //<>//
    } //<>// //<>//
    readableList[i] = time; //<>//
    
    i = 0; //<>//
    while (readableList[i] != 0){ //<>// //<>//
      System.out.println(readableList[i]); //<>// //<>//
     ++i;  //<>// //<>//
    } //<>//
  }
  
  //format the millis time
  int seconds(float currentTime) {
    return (int)(currentTime/ 1000) % 60;
  }
  int minutes(float currentTime) {
    return (int)(currentTime / (1000*60)) % 60;
  }
  int hours(float currentTime) {
    return (int)(currentTime / (1000*60*60)) % 24;
  }
 
 //converts the millis time to string
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
  
  //return the best score in a string format
  String returnHighScores(){
 
    float smallest = readableList[0];
    for(int i = 0; i < readableList.length; ++i){
      if(readableList[i] < smallest && readableList[i] != 0){
        smallest = readableList[i];
      }
    }
    return convertToString(smallest);
  }

  
 
  HighScores(){
    readableList = new float[50];
  }
  
}