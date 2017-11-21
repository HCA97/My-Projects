int scl = 20; // size of the snake and food
int health = 3; // player has three chances
int inv = 0; 
int inc = 2; // increasing the drops' falling speed
boolean hitd = false; // true if the snake hits one of the drops
boolean hitb = false; // true if the snake hits itself

Player s;
Drop [] d = new Drop[15];
Food f;

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
TickRate rateControl;
FilePlayer filePlayer;
AudioOutput out;
AudioSample blop;

String fileName = "p.mp3";

void setup(){
  size(600, 600);
  frameRate(10);
  noStroke();
 // creating the game objects
  s = new Player();
  f = new Food();
  for (int i = 0; i < d.length; i++)
    d[i] = new Drop();

  minim = new Minim(this);
  blop = minim.loadSample( "splat.mp3",512); // trigger when snake eats a food

  filePlayer = new FilePlayer( minim.loadFileStream(fileName));
  //filePlayer.play();
  filePlayer.loop();
  rateControl = new TickRate(1.f);
  out = minim.getLineOut();
  filePlayer.patch(rateControl).patch(out);
}
void keyPressed(){
  if(health > 0){
    // snake can't go backwards unless its size is zero
    if(keyCode == UP){
      if(s.yspeed != 1 || s.point == 0)
         s.dir(0, -1);
    }
    else if (keyCode == DOWN){
      if(s.yspeed != -1 || s.point == 0)
         s.dir(0, 1);
    }
    else if (keyCode == RIGHT){
      if(s.xspeed != -1 || s.point == 0)
         s.dir(1, 0);
    }
    else if(keyCode == LEFT){
      if(s.xspeed != 1 || s.point == 0)
         s.dir(-1, 0);
    }
    if (keyCode == SHIFT && keyPressed)
        s.point++;
  }
}

void draw(){
  background(51);

  if (s.eat(f)){ // checks does snake eat the food
    f.pickLocation(); // new food created
    blop.trigger();
  }
  s.update();
  s.show();
  for(Drop drop: d){
      drop.update();
      drop.fall();
  }
  s.death(d); // checks is snake hit itself or drops
  s.healthBar(); // shows the current health of the snake
  f.update();
}

class Drop {
  float x, y; // starting location
  float yspeed; // falling speed
  float size;

  Drop(){
      x = random(2*scl, width);
      y = random(0, -100);
      yspeed = random(5,10);
      size = random(scl, 2*scl);
  }
  void update(){
      fill(0);
      ellipse(x,y,size,size);
  }
  void fall(){
      y = y + yspeed; 
      if (y > height){ // create new drop object
          x = random(0, width);
          y = random(0, -100);
          x = constrain(x,scl,width-scl);
          if (s.point%5 == 0 && s.point != 0){ // speed up the falling speed  
              inc = 2;
              yspeed += inc;
          }
          else if (s.point == 0){
              inc = 0;
              yspeed = random(5,10); 
          }
      }
    } 
}

class Food {
  float x, y; // location
  Food(){
      this.pickLocation();
  }
  void pickLocation() {
    int cols = (width-scl)/scl;
    int rows = (height-scl)/scl;

    x = (scl/2)+scl*floor(random(cols));
    y = (scl/2)+scl*floor(random(rows));
  }
  void update() {
     fill(255,0,100);
     noStroke();
     ellipse(x, y, scl, scl);
  }
}


class Player {
  float x,y; // location of the head
  float xspeed, yspeed; 
  int point;
  ArrayList<PVector> body;
  
  Player(){
      x = scl/2;
      y = height-scl/2;
      xspeed = yspeed = 0;
      point = 0;
      body = new ArrayList<PVector>(); 
  }
  
  boolean eat(Food f){
    float d = dist(x,y,f.x,f.y);
    if(d < 1){
      point++;
      return true;
    }
    return false;
  }
  
  void dir(float x, float y){
    xspeed = x;
    yspeed = y;
  }
  
  void death(Drop p[]){
    // checks is snake hit one of the drops
    for (int i = 0; i < p.length; i++){
      float d = dist(x, y, p[i].x, p[i].y);
      if (d < (p[i].size/2)+(scl/2))
          hitd = true;
    }
    // checks is snake hit itself
    for (int i = 0; i < body.size(); i++){
      PVector pos = body.get(i);
      float d = dist(x, y, pos.x, pos.y);
      if (d < 1)
        hitb = true;
    }
    if((hitd || hitb) && inv == 0){
      health -=1;
      inv = 5;
    }
    if(health <= 0){    
      x = scl/2;
      y = height-scl/2;
      point = 0;
      fill(0,255,255);
      strokeWeight(4);
      textSize(32);
      text("GAME OVER",(width-200)/2,(height-50)/2);
      textSize(20);
      text("Press Space To Start",(width-210)/2,(height)/2);
      if (key == ' ' && keyPressed){ // re-start the game
          health = 3;
          body.clear();
          xspeed = 0; 
          yspeed = 0;
      }
    }
    if(inv != 0 && inv > 0){
        inv--;
    }
  }
  void update() {
   if(health > 0){
      if(point > 0) {
        if(point == body.size() && !body.isEmpty())
          body.remove(0); // it works like Queue first in first out
        body.add(new PVector(x,y));
      }
      x = x + xspeed*scl;
      y = y + yspeed*scl;
      
      if(x > width)
        x = scl/2;

      else if (x < scl/2)
        x = width-scl/2;

      if(y > height)
        y = scl/2;

      else if (y < scl/2) 
        y = height-scl/2;

   }
 }
 void show(){
   if(hitd || hitb || inv != 0) {
     fill(255,0,0);
     hitd = false;
     hitb = false;
   }
   else
     fill(255);
   if(health > 0){
     for (int i = 0; i < body.size(); i++)
        ellipse(body.get(i).x, body.get(i).y, scl, scl);
     ellipse(x,y,scl,scl);
   }
 }
 
 void healthBar(){
    float hx = 10;
    float hy = 20;
    for(int i = 0; i < health; i++){
      fill(255,0,0);
      textSize(15);
      text("♥",hx,hy);
      hx += scl;
    }
  }
}