class Neuron{
  //Vector[] layers;
  
  Vector in;
  
  // connection weights between neurons
  //Vector lastConnection;
  //Matrix[] connection;
  DNA D;

  Neuron(int input, int hiddenLayer){
     in = new Vector(1,input, false);
     
     /*layers = new Vector[hiddenLayer];
     for (int i = 0; i < layers.length; i++)
       layers[i] = new Vector(1,input, false);
     */ 
     
     D = new DNA(input, hiddenLayer);
     
     // This section removed to DNA class
     /*connection = new Matrix[hiddenLayer];
     for (int i = 0; i < connection.length; i++)
       connection[i] = new Matrix(input,input, true);
     lastConnection = new Vector(1, input, true);
     */
  }
   
Neuron(DNA d){ // Neuron with specified DNA
      D = d;
      in = new Vector(1, d.lastConnection.r, false);
  }
  
  
  float activation(Obstacle[] o){
     for(Obstacle obs : o){
         if(obs.closer){
           // setting input data
           in.data[0][0] = obs.h + D.bais.data[0][0];
           in.data[1][0] = P.pop[index].distanceX(obs) + D.bais.data[0][0];
           in.data[2][0] = xspeed + D.bais.data[0][0];
           in.data[3][0] = obs.w + D.bais.data[0][0];
           
           Vector tmp = in;
           Vector tmp2;
          
           for (int i = 0; i < D.connection.length; i++){
             tmp.add_slacar(D.bais.data[i+1][0]);
             tmp2 = tmp;
             tmp = D.connection[i].mul(tmp2);
             //for(int j = 0; j < tmp.r; j++)
             //    tmp.data[j][0] = sigmoid(tmp.data[j][0]);
           }
           return sigmoid(tmp.dot_product(D.lastConnection));
         } 
     }
     return 0.0;
  }
  
  float sigmoid(float x){
     return (1/(1+exp(-x)));
  }
}