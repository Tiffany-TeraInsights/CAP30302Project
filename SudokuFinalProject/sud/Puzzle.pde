class Puzzle {
  int p[][]=new int[9][9];
  IntList nums=new IntList();
  
  Puzzle() {
    nums.append(1);
    nums.append(2);
    nums.append(3);
    nums.append(4);
    nums.append(5);
    nums.append(6);
    nums.append(7);
    nums.append(8);
    nums.append(9);
    nums.shuffle();
    for (int i=0; i<9; i++) {
      p[0][i]=nums.get(i);
    }
    for (int i=1; i<9; i++) {
      for (int j=0; j<9; j++) {
        p[i][j]=0;
      }
    }
    nums.sort();
    Boolean check=generateSolution(0,0);
    //easy();
    hard();
    printArray();
    printPuzzle();
  }
  
  void easy() {
    int count =1;
    int rI=(int)random(0,9);
    int rJ=(int)random(0,9);
    p[rI][rJ]=0;
    while (count<42) {
      int puzzleCopy[][]=new int[9][9];
      for (int i=0; i<9; i++) {
        for (int j=0; j<9; j++) {
          puzzleCopy[i][j]=p[i][j];
        }
      }
      rI=(int)random(0,9);
      rJ=(int)random(0,9);
      if (p[rI][rJ]!=0) {
        puzzleCopy[rI][rJ]=0;
        if (testIndex(puzzleCopy,0,0,rI,rJ,p[rI][rJ])) {
          p[rI][rJ]=0;
          count++;
        }
      }
      if (count<30) {
        if(puzzleCopy[8-rI][8-rJ]!=0) {
          puzzleCopy[8-rI][8-rJ]=0;
          if (testIndex(puzzleCopy,0,0,8-rI,8-rJ,p[8-rI][8-rJ])) {
            p[8-rI][8-rJ]=0;
            count++;
          }
        }
      }
    }
  }
  
  void hard() {
    int count =1;
    int rI=(int)random(0,9);
    int rJ=(int)random(0,9);
    p[rI][rJ]=0;
    while (count<55) {
      int puzzleCopy[][]=new int[9][9];
      for (int i=0; i<9; i++) {
        for (int j=0; j<9; j++) {
          puzzleCopy[i][j]=p[i][j];
        }
      }
      rI=(int)random(0,9);
      rJ=(int)random(0,9);
      if (p[rI][rJ]!=0) {
        puzzleCopy[rI][rJ]=0;
        if (testIndex(puzzleCopy,0,0,rI,rJ,p[rI][rJ])) {
          p[rI][rJ]=0;
          count++;
        }
      }
      if (count<30) {
        if(puzzleCopy[8-rI][8-rJ]!=0) {
          puzzleCopy[8-rI][8-rJ]=0;
          if (testIndex(puzzleCopy,0,0,8-rI,8-rJ,p[8-rI][8-rJ])) {
            p[8-rI][8-rJ]=0;
            count++;
          }
        }
      }
    }
  }
  
  Boolean generateSolution(int a, int b) {
    int k;
    if (a==8 && b==8) {
      return true;
    }
    else {
      for (int i=0; i<9; i++) {
        for (int j=0; j<9; j++) {
          k=0;
          if (p[i][j]==0) {
            while (k<9) {
              p[i][j]=nums.get(k);
              if (!checkRowsCols(p) || !checkBlocks(p)) {
                p[i][j]=0;
                k++;
                if (k==9) {
                  return false;
                }
              }
              else {
                if(!generateSolution(i,j)) {
                  k++;
                  if (k==9) {
                    p[i][j]=0;
                    return false;
                  }
                }
                else {
                  return true;
                }
              }
            }
          }
        }
      }
    }
    return true;
  }
  
  Boolean checkIndex(int puz[][], int a, int b) {
    int k;
    if (a==8 && b==8) {
      return true;
    }
    else {
      for (int i=0; i<9; i++) {
        for (int j=0; j<9; j++) {
          k=0;
          if (puz[i][j]==0) {
            while (k<9) {
              puz[i][j]=nums.get(k);
              if (!checkRowsCols(puz) || !checkBlocks(puz)) {
                puz[i][j]=0;
                k++;
                if (k==9) {
                  return false;
                }
              }
              else {
                if(!checkIndex(puz,i,j)) {
                  k++;
                  if (k==9) {
                    puz[i][j]=0;
                    return false;
                  }
                }
                else {
                  return true;
                }
              }
            }
          }
        }
      }
    }
    return true;
  }
  
  Boolean testIndex(int puz[][],int a, int b, int indexI, int indexJ, int original) {
    for (int k=0; k<9; k++) {
      if (k==original-1) {
      }
      else {
        puz[indexI][indexJ]=nums.get(k);
        if(checkIndex(puz,0,0)) {
          return false;
        }
      }
    }
    return true;
  }
                
  Boolean checkRowsCols(int puz[][]) {
    Boolean rOne, rTwo, rThree, rFour, rFive, rSix, rSeven, rEight, rNine;
    Boolean cOne, cTwo, cThree, cFour, cFive, cSix, cSeven, cEight, cNine;
    rOne=rTwo=rThree=rFour=rFive=rSix=rSeven=rEight=rNine=false;
    cOne=cTwo=cThree=cFour=cFive=cSix=cSeven=cEight=cNine=false;
    for (int i=0; i<9; i++) {
      for (int j=0; j<9; j++) {
        if (puz[i][j]==1) {
          if (rOne) {
            return false;
          }
          else {
            rOne=true;
          }
        }
        if (puz[j][i]==1) {
          if (cOne) {
            return false;
          }
          else {
            cOne=true;
          }
        }
        if (puz[i][j]==2) {
          if (rTwo) {
            return false;
          }
          else {
            rTwo=true;
          }
        }
        if (puz[j][i]==2) {
          if (cTwo) {
            return false;
          }
          else {
            cTwo=true;
          }
        }
        if (puz[i][j]==3) {
          if (rThree) {
            return false;
          }
          else {
            rThree=true;
          }
        }
        if (puz[j][i]==3) {
          if (cThree) {
            return false;
          }
          else {
            cThree=true;
          }
        }
        if (puz[i][j]==4) {
          if (rFour) {
            return false;
          }
          else {
            rFour=true;
          }
        }
        if (puz[j][i]==4) {
          if (cFour) {
            return false;
          }
          else {
            cFour=true;
          }
        }
        if (puz[i][j]==5) {
          if (rFive) {
            return false;
          }
          else {
            rFive=true;
          }
        }
        if (puz[j][i]==5) {
          if (cFive) {
            return false;
          }
          else {
            cFive=true;
          }
        }
        if (puz[i][j]==6) {
          if (rSix) {
            return false;
          }
          else {
            rSix=true;
          }
        }
        if (puz[j][i]==6) {
          if (cSix) {
            return false;
          }
          else {
            cSix=true;
          }
        }
        if (puz[i][j]==7) {
          if (rSeven) {
            return false;
          }
          else {
            rSeven=true;
          }
        }
        if (puz[j][i]==7) {
          if (cSeven) {
            return false;
          }
          else {
            cSeven=true;
          }
        }
        if (puz[i][j]==8) {
          if (rEight) {
            return false;
          }
          else {
            rEight=true;
          }
        }
        if (puz[j][i]==8) {
          if (cEight) {
            return false;
          }
          else {
            cEight=true;
          }
        }
        if (puz[i][j]==9) {
          if (rNine) {
            return false;
          }
          else {
            rNine=true;
          }
        }
        if (puz[j][i]==9) {
          if (cNine) {
            return false;
          }
          else {
            cNine=true;
          }
        }
      }
      rOne=rTwo=rThree=rFour=rFive=rSix=rSeven=rEight=rNine=false;
      cOne=cTwo=cThree=cFour=cFive=cSix=cSeven=cEight=cNine=false;
    }
    return true;
  }
  
  Boolean checkBlocks(int puz[][]) {
    Boolean one, two, three, four, five, six, seven, eight, nine;
    one=two=three=four=five=six=seven=eight=nine=false;
    for (int i=0; i<3; i++) {
      for (int j=0; j<3; j++) {
        for (int k=0; k<3; k++) {
          for (int l=0; l<3; l++) {
            if (puz[3*i+k][3*j+l]==1) {
              if (one) {
                return false;
              }
              else {
                one=true;
              }
            }
            if (puz[3*i+k][3*j+l]==2) {
              if (two) {
                return false;
              }
              else {
                two=true;
              }
            }
            if (puz[3*i+k][3*j+l]==3) {
              if (three) {
                return false;
              }
              else {
                three=true;
              }
            }
            if (puz[3*i+k][3*j+l]==4) {
              if (four) {
                return false;
              }
              else {
                four=true;
              }
            }
            if (puz[3*i+k][j*3+l]==5) {
              if (five) {
                return false;
              }
              else {
                five=true;
              }
            }
            if (puz[3*i+k][3*j+l]==6) {
              if (six) {
                return false;
              }
              else {
                six=true;
              }
            }
            if (puz[3*i+k][3*j+l]==7) {
              if (seven) {
                return false;
              }
              else {
                seven=true;
              }
            }
            if (puz[3*i+k][3*j+l]==8) {
              if (eight) {
                return false;
              }
              else {
                eight=true;
              }
            }
            if (puz[3*i+k][3*j+l]==9) {
              if (nine) {
                return false;
              }
              else {
                nine=true;
              }
            }
          }
        }
        one=two=three=four=five=six=seven=eight=nine=false;
      }
    }
    return true;
  }
  
  void printPuzzle() {
    for (int i=0; i<9; i++) {
      if (i%3==0) {
        println("");
      }
      for (int j=0; j<9; j++) {
        if (j%3==0) {
          print("  ");
        }
        print(p[i][j]+" ");
      }
      println("");
    }
  }
  
  void printArray() {
    for (int i=0; i<9; i++) {
      for (int j=0; j<9; j++) {
        print(p[i][j]+",");
      }
    }
  }
  
}
  
  
        
          