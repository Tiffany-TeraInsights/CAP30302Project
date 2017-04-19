class PencilIn {
  IntList[][] pencil=new IntList[9][9];

  PencilIn() {
  }
  
  //creating a new int list at every location
  void create(int p[][]) {
    for (int i=0; i<9; i++) {
      for (int j=0; j<9; j++) {
        pencil[i][j]=new IntList();
        if (p[i][j]!=0) {
          pencil[i][j].append(0);
        }
      }
    }
  }
  

  // function to modify content of each box, adds or removes numbers based on user input
  void modify(int input, int box) {
    boolean remove=false;
    if (pencil[box/9][box%9].hasValue(0)) {
      pencil[box/9][box%9].clear();
      pencil[box/9][box%9].append(input);
    } else {
      for (int i=pencil[box/9][box%9].size()-1; i>=0; i--) {
        if (pencil[box/9][box%9].get(i)==input) {
          pencil[box/9][box%9].remove(i);
          remove=true;
        }
      }
      if (!remove) {
        pencil[box/9][box%9].append(input);
        pencil[box/9][box%9].sort();
      }
    }
  }
  
  
  // when a cell is filled in (marked), it removes the pencil markings (sets it to 0)
  void update(int p[][]) {
    for (int i=0; i<9; i++) {
      for (int j=0; j<9; j++) {
        if (p[i][j]!=0) {
          pencil[i][j].clear();
          pencil[i][j].append(0);
        }
      }
    }
  }
}