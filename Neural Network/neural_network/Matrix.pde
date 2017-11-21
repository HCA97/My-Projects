//  Vector and Matrix Calsses for My Neural Network
class Matrix{
  float[][] data;
  int r,c;
  
  Matrix(int x, int y, boolean random){
      data = new float[y][x]; // x : columns, y : rows
      if (random)
        for(int row = 0; row < y; row++)
          for(int col = 0; col < x; col++)
              data[row][col] = random(-1,1);
      r = y; c = x;
  }
 /*  
  void Print(){
  
    for(int row = 0; row < r; row ++){
       for(int col = 0; col < c; col ++)
           print(data[row][col],"-");
    
    println("\n----------------------");
    }
  } 
  */
 
  Vector mul(Vector v){ // Matrix Vector multiplication
    // precondition : entering correct size vector(Vector row = Matrix col)
      Vector solution = new Vector(v.c,r,false);
      for(int row = 0; row < solution.r; row ++)
        for(int col = 0; col < solution.c; col ++)
          for(int k = 0; k < c; k ++)
            solution.data[row][col] += data[row][k]*v.data[k][col];
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
  
  void add_scalar(float b){
      for(int row = 0; row < r; row ++)
        for(int col = 0; col < c; col ++)
              data[row][col] += b;
  }


}

class Vector extends Matrix{
  Vector(int x, int y, boolean random){
      super(x,y,random);
  }
  Vector trans(){ // takes the transpose of the vector
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