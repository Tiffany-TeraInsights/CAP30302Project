class Hints { //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//

  int hintCost;
  int[][] possibilityMatrix;
  int randomRow;
  int randomColumn;

  int returnHintCost() {
    return hintCost;
  }

  void changeHintCost(float multiplier) {
    hintCost *= multiplier;
  }


  Hints(int initialCost) {
    hintCost = initialCost;
  }

  int giveHint(int box, int puzzle[][]) {
    return puzzle[box/9][box%9];
  }

  int[][] getHint(int puzzleUnsolved[][], int puzzleSolved[][]) {
    int numOfPoss = 5;
    while (numOfPoss > 2) {
      randomRow = (int)random(0, 9);
      randomColumn = (int)random(0, 9);
      numOfPoss = generatePossibilityMatrix(puzzleUnsolved, randomRow, randomColumn);
      System.out.println("NumOfPoss " + numOfPoss);
    }
    puzzleUnsolved[randomRow][randomColumn] = puzzleSolved[randomRow][randomColumn];
    return puzzleUnsolved;
  }

  int generatePossibilityMatrix(int puzzleUnsolved[][], int row, int column) {
    int[][] boxes = new int[9][9];

    //int[][][] possibilities = {};
    //int[] nonPossibilites = {};
    //int currentBox;
    for (int i = 0; i < 9; ++i) {
      for (int j = 0; j < 9; ++j) {
        if (puzzleUnsolved[i][j] != 0) {
          int boxNum = 0;
          if (i < 3 && j < 3) {
            boxNum = 0;
          } else if ( i >= 3 && i < 6 && j < 3) {
            boxNum = 3;
          } else if ( i >= 6 && i < 9 && j < 3) {
            boxNum = 6;
          } else if (i < 3 && j >= 3 && j < 6) {
            boxNum = 1;
          } else if (i >= 3 && i < 6 && j >= 3 && j < 6) {
            boxNum = 4;
          } else if (i >= 6 && i < 9 && j >= 3 && j < 6) {
            boxNum = 7;
          } else if (i < 3 && j >= 6 && j < 9) {
            boxNum = 2;
          } else if (i >= 3 && i < 6 && j >= 6 && j < 9) {
            boxNum = 5;
          } else if (i >= 6 && i < 9 && j >= 6 && j < 9) {
            boxNum = 8;
          }
          boxes[boxNum][(puzzleUnsolved[i][j] - 1)] = puzzleUnsolved[i][j];
        }
      }
    }

    int[] nonPossibilities = new int[9];
    int boxNum = 0;
    int possible = 0;

    if (puzzleUnsolved[row][column] != 0) {
      return 9;
    } else {

      for (int t = 0; t < 9; ++t) {
        if (puzzleUnsolved[t][column] != 0) {
          nonPossibilities[(puzzleUnsolved[t][column] - 1)]++;
        }
      }

      for (int p = 0; p < 9; ++p) {
        if (puzzleUnsolved[row][p] != 0) {
          nonPossibilities[(puzzleUnsolved[row][p] - 1)]++;
        }
      }

      if (row< 3 && column < 3) {
        boxNum = 0;
      } else if ( row>= 3 && row< 6 && column < 3) {
        boxNum = 3;
      } else if ( row>= 6 && row< 9 && column < 3) {
        boxNum = 6;
      } else if (row< 3 && column >= 3 && column < 6) {
        boxNum = 1;
      } else if (row>= 3 && row< 6 && column >= 3 && column < 6) {
        boxNum = 4;
      } else if (row>= 6 && row< 9 && column >= 3 && column < 6) {
        boxNum = 7;
      } else if (row< 3 && column >= 6 && column < 9) {
        boxNum = 2;
      } else if (row>= 3 && row< 6 && column >= 6 && column < 9) {
        boxNum = 5;
      } else if (row>= 6 && row< 9 && column >= 6 && column < 9) {
        boxNum = 8;
      }

      for (int f = 0; f < boxes[boxNum].length - 1; ++f) {
        if (boxes[boxNum][f] != 0) {
          //System.out.println("boxNum " + boxNum);
          //System.out.println("f " + f);
          //System.out.println(" together " + boxes[boxNum][f]);
          nonPossibilities[(boxes[boxNum][f]) - 1]++;
        }
      }

      for (int x = 0; x < nonPossibilities.length; ++x) {
        if (nonPossibilities[x] == 0) {
          possible++;
        }
      }
    }
    System.out.println("Possible " + possible);
    return possible;
  }


  void getBestHint(int[][][] possible, int[][] puzzleUnsolved, int[][] puzzleSolved) {

    int smallest = 10; 
    int row = 0; 
    int column = 0; 

    for (int i = 0; i < 9; ++i) {
      for (int j = 0; j < 9; ++i) {
        if (possible[i][j].length < smallest) {
          smallest = possible[i][j].length; 
          row = i; 
          column = j;
        }
      }
    }
    puzzleUnsolved[row][column] = puzzleSolved[row][column];
  }
}