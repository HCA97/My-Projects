class Population{
  AIplayer[] pop;
  
  Population(int size){
    pop = new AIplayer[size];
    for(int i = 0; i < pop.length; i ++)
        pop[i] = new AIplayer();
  }
  
  ArrayList<AIplayer> maitingPool(){
        ArrayList<AIplayer> mating = new ArrayList<AIplayer>();
        
        for (int i = 0; i < pop.length; i++)
            for (int j = 0; j < (int) pop[i].fitness*100; j++)
                 mating.add(pop[i]);  
                 
        return mating;
  }
  
  void newGeneration(){  // creates a new generation using mating pool
          ArrayList<AIplayer> m = this.maitingPool(); // creating mating pool
          DNA child;
          
          for (int i = 0; i < pop.length; i++){
              int index1 = (int) random(0, m.size()); // picking the parents
              int index2 = (int) random(0, m.size());
              
              AIplayer mother = m.get(index2);
              AIplayer father = m.get(index1);
              
              child = father.N.D.crossover(mother.N.D); // simple crossover
              child.mutation(); // 5 percent change of mutation
              
              NN n = new NN(child);
              AIplayer c = new AIplayer(n); // creating an individual with new DNA
              pop[i] = c; 
      
          }
  }
}