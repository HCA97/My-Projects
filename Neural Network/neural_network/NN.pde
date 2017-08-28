class Neuron{
  // connection weights between neurons and bais values
  DNA D;

  Neuron(int input, int hiddenLayer){
     D = new DNA(input, hiddenLayer); 
  }
   
  Neuron(DNA d){ // Neuron with specified DNA
      D = d;
  }
  
  
  float activation(Vector in){
       in.add_scalar(D.bais.data[0][0]);
       
       Vector tmp = in;
       Vector tmp2;
      
       for (int i = 0; i < D.connection.length; i++){
         tmp.add_scalar(D.bais.data[i+1][0]);
         tmp2 = tmp;
         tmp = D.connection[i].mul(tmp2);
         for(int j = 0; j < tmp.r; j++)
           tmp.data[j][0] = sigmoid(tmp.data[j][0]);
       }
       return sigmoid(tmp.dot_product(D.lastConnection));
  }
    
  float sigmoid(float x){
     return (1/(1+exp(-x)));
  }
}
