class Population{
  Player[] pop = new Player[10];
  int best, worst;
  
  Population(){
    for(int i = 0; i < pop.length; i ++)
        pop[i] = new Player();
  }
  
  /*void calculateFitness(){
      if(best == worst)
          for(int i = 0; i < pop.length; i++)
              pop[i].fitness = 1.0;
      else
          for(int i = 0; i < pop.length; i++)
              pop[i].fitness = map(pop[i].points, worst, best, 0, 1); // eliminates the worst player
  }
  */
  void BestWorst(){
      int max = pop[0].fitness, min = pop[0].fitness;
      for(Player p: pop){
         if(p.points > max)
             max = p.fitness;
         if(p.points < min)
             min = p.fitness;
      }
      best = max;
      worst = min;
  }
  
  ArrayList<Player> maitingPool(){
        ArrayList<Player> mating = new ArrayList<Player>();
        //this.calculateFitness();
        
        for (int i = 0; i < pop.length; i++)
            for (int j = 0; j < (int) pop[i].fitness*10; j++)
                 mating.add(pop[i]);  
                 
        return mating;
  }
  
  void newGeneration(){  // creates a new generation using mating pool
        //this.BestWorst();
        //if(best != 0){
          ArrayList<Player> m = this.maitingPool(); // creating mating pool
          DNA child;
          
          for (int i = 0; i < pop.length; i++){
              int index1 = (int) random(0, m.size()); // picking the parents
              int index2 = (int) random(0, m.size());
              
              Player mother = m.get(index2);
              Player father = m.get(index1);
              
              child = father.N.D.crossover(mother.N.D); // simple crossover
              child.mutation(); // 10 percent change of mutation
              
              Neuron n = new Neuron(child);
              Player c = new Player(n); // creating an individual with new DNA
              pop[i] = c; 
      
          }
        }
        /*else
          for (int i = 0; i < pop.length; i++)
            pop[i].N.D.mutation();
         */ 
    }