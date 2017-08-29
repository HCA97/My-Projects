class DNA{
  Matrix[] connection;
  Matrix bais;
  
  DNA(int input, int[] Layer){
    
     connection = new Matrix[Layer.length];
     connection[0] = new Matrix(input, Layer[0], true);
     for (int i = 1; i < connection.length; i++)
       connection[i] = new Matrix(Layer[i-1],Layer[i], true);
       
     bais = new Matrix(1, Layer.length, true);
  }
  
  DNA(Matrix[] h, Vector b){ // specified DNA
     connection = h;
     bais = b;
  }
  
  DNA crossover(DNA d){ // Simple Crossover 
  // Shuffles the rows
     
      Matrix[] c = new Matrix[connection.length];
      Vector b = bais;
      
      for(int i = 0; i < c.length; i++)
          c[i] = connection[i].mix(d.connection[i]);
      
      int cut = round(random(d.bais.r));

      for(int i = 0; i < cut; i++)
              b.data[i][0] = d.bais.data[i][0];

       DNA solution = new DNA(c, b);
       return solution;
  }
          
 
  
  void mutation(){
    // Mutation for connections
    // Mutation rate %5
            
       for(Matrix m : connection)
         for(int row = 0; row < m.r; row++)
           for(int col = 0; col < m.c; col++)
             if (mutation_rate > random(1))
                 m.data[row][col] = m.data[row][col]*random(-2,2) + random(-5,5);
       
       for(int row = 0; row < bais.r; row++)
            if (mutation_rate > random(1))
                 bais.data[row][0] = 
                 bais.data[row][0]*random(-2,2) + random(-5,5);
  }



}
