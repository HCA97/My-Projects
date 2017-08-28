
class NN{
  // connection weights between neurons and bais values
  DNA D;

  NN(int input, int[] hiddenLayer){
     D = new DNA(input, hiddenLayer); 
  }

  Neuron(DNA d){ // Neuron with specified DNA
      D = d;
  }
  
  
  float activation(Vector in){
    
       Vector tmp = in;
       Vector tmp2;
       for (int i = 0; i < D.connection.length; i++){
         tmp2 = tmp;
         tmp = D.connection[i].mul(tmp2);
         tmp.add_scalar(D.bais.data[i][0]);
         for(int j = 0; j < tmp.r; j++)
           tmp.data[j][0] = sigmoid(tmp.data[j][0]);
       }
       return sigmoid(tmp.data[0][0]);
  }
    
  float sigmoid(float x){
     return (1/(1+exp(-x)));
  }
}
