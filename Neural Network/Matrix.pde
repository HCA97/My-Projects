class Matrix{
  float[][] data;
  int r,c;
  
  Matrix(int x, int y, boolean random){
      data = new float[y][x]; // x : columns, y : rows
      if (random)
        for(int row = 0; row < y; row++)
          for(int col = 0; col < x; col++)
              data[row][col] = random(-10,10);
      else
        for(int row = 0; row < y; row++)
          for(int col = 0; col < x; col++)
              data[row][col] = 0;
      r = y; c = x;
  }
 
  Vector mul(Vector M){ // precondition : entering correct size vector
      Vector solution = new Vector(M.c,r,false);
      for(int row = 0; row < solution.r; row ++)
        for(int col = 0; col < solution.c; col ++)
          for(int k = 0; k < c; k ++)
            solution.data[row][col] += data[row][k]*M.data[k][col];
      return solution;
    
  }
  
  Matrix mix(Matrix m){  // precondition : Both matrixes has to be same size
      Matrix solution = new Matrix(c,r,false);
      for(int row = 0; row  < r; row++){
          if(0.5 < random(1))
              for(int col = 0; col < c; col++)
                  solution.data[row][col] = m.data[row][col];
          else
              for(int col = 0; col < c; col++)
                  solution.data[row][col] = data[row][col];
        }
      return solution;     
  }
  
  void add_slacar(float b){
      for(int row = 0; row < r; row ++)
        for(int col = 0; col < c; col ++)
              data[row][col] += b;
  }


}

class Vector extends Matrix{
  Vector(int x, int y, boolean random){
      super(x,y,random);
  }
  Vector trans(){
        Vector data_trans = new Vector(r,c,false);
        for(int row = 0; row < c; row++)
          for(int col = 0; col < r; col++)
              data_trans.data[row][col] = data[col][row];
        return data_trans;
  }
  float dot_product(Vector v){
      return this.mul(v.trans()).data[0][0];
  }

}