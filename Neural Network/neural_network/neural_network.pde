// Game Features
PVector gravity = new PVector(0,1); // how fast loosing the y-speed
int scl = 20; // size of the player
int points = 0; 
boolean hit = false;
boolean dead = false;
float initial_speed = scl/3;
float xspeed = initial_speed; // inital speed of the obstacle
float dis = 8*width; // distance between two obstacles
int maxW = 6*scl, minW = 4*scl; // parameters for obstacle width
int maxH = 8*scl, minH = 7*scl; // parameters for obstacle height

// For Recording Values
int sum = 0;
int best = 0;
int Best = 0, Worst = 10000;float Mean = 0;
Table table; // Storing Best, Worst, Average of each generation
Table dna;  // Storing the Best DNA
TableRow[] newRows, dnaRows; 

// AI features
Vector in; // input Vector
int pass = 1; // fitness values for AI default 1
// Hyper-Parameters
int input_size = 4; int [] layer = {4,1}; // index represents which layer, numbers represent amount of neuron in that layer
int population_size = 10;
float mutation_rate = 0.05;

// Extras
int index = 0;
int Generation = 1;
boolean AI = true;  // if false then player plays the game
boolean train = true; // if false then AI stops training


// Game Objects
Population P;
Obstacle [] O;
Player p;



void setup(){
  randomSeed(0); // for debugging and removing RNG
  size(800,400);

  in = new Vector(1,4,false);
  p = new Player();
  
  O = new Obstacle[2];
  for (int i  = 0; i < O.length;i++)
      O[i] = new Obstacle(i);
  O[0].closer = true;
  O[1].closer = false;
  

  P = new Population(population_size);
  dna = new Table();
  for(int i = 0; i < input_size; i ++)
      dna.addColumn("Layer"+str(0)+str(i));
  for (int i = 1; i< layer.length; i++)
    for(int j = 0; j < layer[i-1]; j++)
        dna.addColumn("Layer"+str(i)+str(j));
 
  dna.addColumn("bais");
  
  dnaRows = new TableRow[max(max(layer),input_size, layer.length)];
  for(int i = 0; i < dnaRows.length; i++)
        dnaRows[i] = dna.addRow();
  
  table = new Table();
  table.addColumn("Best");
  table.addColumn("Worst");
  table.addColumn("Mean");
  
  newRows = new TableRow[100]; // At most 100 generations
  for (int i = 0; i < newRows.length; i++)
      newRows[i] = table.addRow();  
  
  textSize(24);
  noStroke();
}

void keyPressed(){
    train = !train;
}

void draw(){
  background(0);
  if(AI){
      dead = false;
      //P.pop[index].N.D.show();
      P.pop[index].show();
      P.pop[index].update();
      for(Obstacle obs : O){
             if(obs.closer){
               in.data[0][0] = obs.h/maxH;
               in.data[1][0] = obs.w/maxW;
               in.data[2][0] = xspeed;
               in.data[3][0] = P.pop[index].distanceX(obs);
               break;
             }
      }
      if (P.pop[index].N.activation(in) > 0.65 && P.pop[index].pos.y == height-scl){
          PVector up = new PVector(0, -22);
          P.pop[index].applyForce(up);
      }
      
      for(int i = 0; i < O.length; i++){
        boolean hit = O[i].hits(P.pop[index]);
        O[i].show(hit);
        if(hit) {
           if(train){
               if(Best < points)
                   Best = points;
               if(Worst  > points)
                   Worst = points;
               // Storing the DNA
               if (best < points){
                  best = points;
                  
                  for(int j = 0; j < P.pop[index].N.D.connection.length; j++)
                    for(int col = 0; col < P.pop[index].N.D.connection[j].c; col++)
                        for(int row = 0; row < P.pop[index].N.D.connection[j].r; row++)
                            dnaRows[row].setFloat("Layer"+str(j)+str(col),P.pop[index].N.D.connection[j].data[row][col]);
                        
                  for(int j = 0; j < P.pop[index].N.D.bais.r; j++)
                        dnaRows[j].setFloat("bais",P.pop[index].N.D.bais.data[j][0]);
                        
                  saveTable(dna, "data/dna.csv"); 
               }
              
               P.pop[index].fitness = pass;
               sum += points;
               index++;
           }
           // setting everthing to initial state
           points = 0;
           pass = 1;
           xspeed = scl/3;
           dead = true;
           
           for (int j  = 0; j < O.length;j++)
              O[j] = new Obstacle(j);
           O[0].closer = true;
           O[1].closer = false;
           
           break;
        }
        O[i].move();
        if(O[i].x < -O[i].w){ 
          float w = random(minW,maxW);
          float h = random(minH,maxH);
          O[i] = new Obstacle(O[O.length - 1 - i].x + dis, height-h, w, h);
          
          O[i].closer = false;
          O[O.length - 1 - i].closer = true;
          
          pass ++;
        }
      }
      if(points%300 == 0 && points != 0)
        xspeed++;
    
      fill(0,255,255);
      
      text("Points - ", 400, 30);
      text(points, 500,30);

      text("Generation - ", 20, 30);
      text(Generation, 180,30);
      
      text("Player - ", 230, 30);
      text(index+1, 330,30);
      
      text("Fitness - ", 580, 30);
      text(pass-1, 690,30);

      if(!dead)
          points ++;
      if(index > P.pop.length - 1){
        if(train){
            Mean = 0;
            Mean = (float) sum/P.pop.length;
            println("-----------------");
            println("Best -", Best);
            println("Worst -", Worst);
            println("Mean -", Mean);
  
            
            newRows[Generation-1].setInt("Best",Best);
            newRows[Generation-1].setInt("Worst",Worst);
            newRows[Generation-1].setFloat("Mean",Mean);
            saveTable(table, "data/table.csv"); 
            Generation++;
            P.newGeneration();
            
            Worst = 10000;
            Best = 0;
            
            sum = 0;
        }
        index = 0;   
      }
  }
  else{
      p.show();
      p.update();
      if (mousePressed && p.pos.y == height-scl){
          PVector up = new PVector(0, -22);
          p.applyForce(up);
          //check = false;
      }
      for(int i = 0; i < O.length; i++){
        O[i].show(O[i].hits(p));
        if(O[i].hits(p)) {
          xspeed = 0;
          gravity.mult(0);
          p.vel.mult(0);
          dead = true;
          if (dead){
                fill(0,255,255);
                textSize(32);
                text("GAME OVER",(width-200)/2,(height-50)/2);
                textSize(20);
                text("Press Space To Start",(width-210)/2,(height)/2);
          }
          if(keyPressed && key == ' '){
            // initialize everything
             for (int j = 0; j < O.length; j++)
                  O[j] = new Obstacle(j);
              points = 0;
              gravity = new PVector(0,0.5);
              p.pos.y = height-scl;
              xspeed = scl/3;
              dead = false;
              break;
          }
      }
        O[i].move();
        if(O[i].x < -O[i].w){ 
          float w = random(minW,maxW);
          float h = random(minH,maxH);
          O[i] = new Obstacle(O[O.length - 1 - i].x + dis, height-h, w, h);
          O[i].closer = false;
          O[O.length - 1 - i].closer = true;
         
        }
      }
      if(points%300 == 0 && points != 0){
        xspeed++;
      }
      fill(0,255,255);
      textSize(32);
      text(points,20,30);
      if(!dead)
          points ++;
  }
}