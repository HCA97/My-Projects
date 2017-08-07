PVector gravity = new PVector(0,1);
int scl = 20, points = 0, pass = 1, index = 0, Generation = 1, sum = 0;
boolean hit = false, dead = false;
float xspeed = scl/3, dis = 8*width, mutation_rate = 0.1;
int best = 0;

Table table;
TableRow[] newRows, dnaRows;
Table dna;

Population P;
Obstacle [] O;
//Player p;


void setup(){
  size(800,400);
  P = new Population();
  //p = new Player();
  
  O = new Obstacle[2];
  for (int i  = 0; i < O.length;i++)
      O[i] = new Obstacle(i);
  O[0].closer = true;
  O[1].closer = false;
  
  
  dna = new Table();
  dna.addColumn("Layer0");
  dna.addColumn("Layer1");
  dna.addColumn("Layer2");
  dna.addColumn("bais");
  
  dnaRows = new TableRow[16];
  for(int i = 0; i < dnaRows.length; i++)
        dnaRows[i] = dna.addRow();
  

  textSize(24);
}

void draw(){
  background(0);
  dead = false;
  P.pop[index].show();
  P.pop[index].update();
  
  if (P.pop[index].N.activation(O) > 0.5 && P.pop[index].pos.y == height-scl){
      PVector up = new PVector(0, -22);
      P.pop[index].applyForce(up);
  }
  
  for(int i = 0; i < O.length; i++){
    O[i].show(O[i].hits(P.pop[index]));
    if(O[i].hits(P.pop[index])) {

       // Storing the DNA
       if (best < points){
          best = points;
          int k = 0;
          for(int j = 0; j < P.pop[index].N.D.connection.length; j++){
            for(int col = 0; col < P.pop[index].N.D.connection[j].c; col++)
                for(int row = 0; row < P.pop[index].N.D.connection[j].r; row++){
                    dnaRows[k].setFloat("Layer"+str(j),P.pop[index].N.D.connection[j].data[row][col]);
                    k++;
                }
                k = 0;
          }
          for(int j = 0; j < P.pop[index].N.D.lastConnection.r; j++)
                dnaRows[j].setFloat("Layer2",P.pop[index].N.D.lastConnection.data[j][0]);
                
          for(int j = 0; j < P.pop[index].N.D.bais.r; j++)
                dnaRows[j].setFloat("bais",P.pop[index].N.D.bais.data[j][0]);
                
          saveTable(dna, "data/dna.csv"); 
       }
      
       P.pop[index].points = points;
       P.pop[index].fitness = pass;
       sum += points;
       index++;
       //println("Player -",index," Points -",points, " Fitness -", pass);
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
      float w = random(3*scl,4*scl);
      float h = random(7*scl,8*scl);
      O[i] = new Obstacle(O[O.length - 1 - i].x + dis, height-h, w, h);
      
      O[i].closer = false;
      O[O.length - 1 - i].closer = true;
      
      pass ++;
    }
  }
  if(points%300 == 0 && points != 0)
    xspeed++;

  fill(0,255,255);
  
  text("Generation - ", 20, 30);
  text(Generation, 180,30);
  
  text("Player - ", 230, 30);
  text(index+1, 330,30);
  
  text("Points - ", 400, 30);
  text(points, 500,30);
  
  text("Fitness - ", 580, 30);
  text(pass-1, 690,30);

  if(!dead)
      points ++;
  if(index > P.pop.length - 1){
      //println("Generation ",Generation, " ended", " Average - ", (float) sum/P.pop.length);
      println(" Average - ", (float) sum/P.pop.length);
      println(" Best - ", best);
      Generation++;
      P.newGeneration();
      index = 0;
      sum = 0;
  }
}

/*
void draw(){
  background(0);
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

      if(keyPressed && key == ' '){
       for (int j = 0; j < O.length; j++){
            O[j] = new Obstacle(i);
        }
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
      float w = random(3*scl,4*scl);
      float h = random(7*scl,8*scl);
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
*/