class DNA{
  Vector lastConnection;
  Matrix[] connection;
  Vector bais;
  
  DNA(int input, int hiddenLayer){
    
     connection = new Matrix[hiddenLayer];
     for (int i = 0; i < connection.length; i++)
       connection[i] = new Matrix(input,input, true);
     lastConnection = new Vector(1, input, true);
     bais = new Vector(1, hiddenLayer+1, true);
  }
  
  DNA(Vector v, Matrix[] c, Vector b){ // specified DNA
     lastConnection = v;
     connection = c;
     bais = b;
  }
  
  DNA crossover(DNA d){ // Simple Crossover 
      Matrix[] c = new Matrix[connection.length];
      Vector b = new Vector(1,bais.r,false);
      Vector v = new Vector(1,lastConnection.r,false);
      
      for(int i = 0; i < c.length; i++)
          c[i] = connection[i].mix(d.connection[i]);
      
      int cut = round(random(lastConnection.r));
      for(int i = 0; i < cut; i++)
              v.data[i][0] = lastConnection.data[i][0];
      for(int i = cut; i < d.lastConnection.r; i++)
              v.data[i][0] = d.lastConnection.data[i][0]; 
      
      cut = round(random(bais.r));
      for(int i = 0; i < cut; i++)
              b.data[i][0] = d.bais.data[i][0];
      for(int i = cut; i < d.bais.r; i++)
              b.data[i][0] = d.bais.data[i][0]; 

       DNA solution = new DNA(v, c, b);
       return solution;
  }
          
 
  
  void mutation(){
    // Mutation for connections
    // Mutation rate %10
    
       for(Matrix m : connection)
         for(int row = 0; row < m.r; row++)
           for(int col = 0; col < m.c; col++)
             if (mutation_rate > random(1))
                 m.data[row][col] = m.data[row][col]*random(-2,2) + random(-5,5);
        
       for(int row = 0; row < lastConnection.r; row++)
            if (mutation_rate > random(1))
                 lastConnection.data[row][0] = 
                 lastConnection.data[row][0]*random(-2,2) + random(-5,5);
       
       for(int row = 0; row < bais.r; row++)
            if (mutation_rate > random(1))
                 bais.data[row][0] = 
                 bais.data[row][0]*random(-2,2) + random(-5,5);
  }



}